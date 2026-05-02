import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

/// Ô nhập liệu dùng chung – khớp với thiết kế Figma (Phase 1 – UI Foundation).
///
/// Đặc điểm:
/// • Bo góc 8 px (Figma), fill nền [AppColors.surfaceTertiary].
/// • Viền mặc định [AppColors.border], focused 2 px [AppColors.primary].
/// • Hỗ trợ: label phía trên (Inter 13 medium), clear button (✕),
///   toggle mật khẩu (👁), dropdown (readOnly + suffixIcon chevron).
///
/// ```dart
/// // Ô tên đăng nhập (có nút ✕)
/// CustomTextField(
///   label: 'Tên đăng nhập',
///   controller: _usernameCtrl,
///   showClearButton: true,
/// )
///
/// // Ô mật khẩu (có icon 👁)
/// CustomTextField(
///   label: 'Mật khẩu',
///   controller: _passwordCtrl,
///   obscureText: true,
///   showTogglePassword: true,
/// )
///
/// // Dropdown-like (readOnly + chevron)
/// CustomTextField(
///   label: 'Đơn vị hiện tại',
///   controller: _unitCtrl,
///   readOnly: true,
///   onTap: () => _showUnitPicker(),
///   suffixIcon: Icon(Icons.keyboard_arrow_down),
/// )
/// ```
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.showTogglePassword = false,
    this.showClearButton = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.borderRadius = 8,
  });

  final TextEditingController? controller;

  /// Nhãn phía trên ô nhập (Inter Medium 13 – màu [AppColors.textSecondary]).
  final String? label;

  /// Placeholder bên trong ô.
  final String? hintText;

  /// Ghi chú phía dưới ô.
  final String? helperText;

  /// Lỗi hiển thị phía dưới ô (ưu tiên hơn [helperText]).
  final String? errorText;

  /// Icon bên trái.
  final IconData? prefixIcon;

  /// Widget bên phải tuỳ chỉnh. Bị ghi đè nếu
  /// [showTogglePassword] hoặc [showClearButton] bật.
  final Widget? suffixIcon;

  /// Ẩn ký tự (mật khẩu).
  final bool obscureText;

  /// Hiện nút bật/tắt hiện mật khẩu (icon 👁).
  final bool showTogglePassword;

  /// Hiện nút xoá nội dung ✕.
  final bool showClearButton;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// Callback khi tap vào trường (hữu ích cho dropdown / date-picker).
  final VoidCallback? onTap;

  final int maxLines;
  final int? maxLength;
  final bool enabled;

  /// Chế độ chỉ đọc.
  final bool readOnly;

  final bool autofocus;
  final FocusNode? focusNode;

  /// Bo góc (mặc định 8 px – khớp Figma).
  final double borderRadius;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  // ── Suffix logic ─────────────────────────────────────────

  Widget? _buildSuffix() {
    // Priority 1: Toggle password
    if (widget.showTogglePassword) {
      return IconButton(
        icon: Icon(
          _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppColors.textHint,
          size: 20,
        ),
        onPressed: () => setState(() => _obscured = !_obscured),
        splashRadius: 18,
      );
    }

    // Priority 2: Clear button (✕)
    if (widget.showClearButton && widget.controller != null) {
      return ValueListenableBuilder<TextEditingValue>(
        valueListenable: widget.controller!,
        builder: (_, value, child) {
          if (value.text.isEmpty) return const SizedBox.shrink();
          return IconButton(
            icon: Icon(
              Icons.cancel_rounded,
              color: AppColors.textHint,
              size: 18,
            ),
            onPressed: () {
              widget.controller!.clear();
              widget.onChanged?.call('');
            },
            splashRadius: 18,
          );
        },
      );
    }

    // Priority 3: Custom widget
    return widget.suffixIcon;
  }

  // ── Build ────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final br = BorderRadius.circular(widget.borderRadius);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Label ──
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              height: 1.38,
            ),
          ),
          const SizedBox(height: 6),
        ],

        // ── TextFormField ──
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: _obscured,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: widget.enabled
                ? AppColors.textPrimary
                : AppColors.textSecondary,
            height: 1.5,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.inter(
              color: AppColors.textHint,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            helperText: widget.errorText == null ? widget.helperText : null,
            helperStyle: GoogleFonts.inter(
              color: AppColors.textHint,
              fontSize: 12,
            ),
            errorText: widget.errorText,
            errorStyle: GoogleFonts.inter(
              color: AppColors.error,
              fontSize: 12,
            ),
            filled: true,
            fillColor: widget.enabled
                ? AppColors.surfaceTertiary
                : AppColors.surfaceVariant,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: AppColors.textHint,
                    size: 20,
                  )
                : null,
            suffixIcon: _buildSuffix(),

            // ── Borders ──
            border: OutlineInputBorder(
              borderRadius: br,
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: br,
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: br,
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: br,
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: br,
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: br,
              borderSide: const BorderSide(color: AppColors.divider),
            ),
          ),
        ),
      ],
    );
  }
}
