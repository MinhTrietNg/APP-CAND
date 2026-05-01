import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

/// Kiểu hiển thị của [CustomButton].
enum ButtonVariant { filled, outlined, text }

/// Nút bấm dùng chung – khớp với thiết kế Figma (Phase 1 – UI Foundation).
///
/// Mặc định: bo góc 8 px, nền primary blue (#1A56E8), chữ trắng,
/// shadow nhẹ, pressed-state chuyển sang [AppColors.primaryDark].
///
/// ```dart
/// // Nút chính (filled)
/// CustomButton(label: 'Đăng nhập', onPressed: () {})
///
/// // Nút viền
/// CustomButton(
///   label: 'Huỷ',
///   variant: ButtonVariant.outlined,
///   onPressed: () {},
/// )
///
/// // Nền đỏ (xoá / cảnh báo)
/// CustomButton(
///   label: 'Xoá',
///   backgroundColor: AppColors.error,
///   onPressed: () {},
/// )
/// ```
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.filled,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 48,
    this.borderRadius = 8,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.fontSize,
    this.expand = false,
  });

  /// Nhãn hiển thị trên nút.
  final String label;

  /// Callback khi nhấn. Truyền `null` để disable.
  final VoidCallback? onPressed;

  /// Kiểu nút: filled (mặc định), outlined, text.
  final ButtonVariant variant;

  /// Hiển thị loading spinner thay vì label.
  final bool isLoading;

  /// Icon tuỳ chọn bên trái label.
  final IconData? icon;

  /// Chiều rộng cố định. `null` = co giãn theo parent.
  final double? width;

  /// Chiều cao (mặc định 48 – khớp Figma).
  final double height;

  /// Bo góc (mặc định 8 px – khớp Figma).
  final double borderRadius;

  /// Ghi đè màu nền (filled) hoặc màu viền (outlined).
  final Color? backgroundColor;

  /// Ghi đè màu chữ / icon.
  final Color? foregroundColor;

  /// Ghi đè màu viền (chỉ dùng cho outlined). Mặc định = foreground.
  final Color? borderColor;

  /// Ghi đè cỡ chữ.
  final double? fontSize;

  /// `true` = chiếm hết chiều ngang (double.infinity).
  final bool expand;

  // ── Helpers ──────────────────────────────────────────────

  bool get _disabled => onPressed == null || isLoading;

  Color get _bg => backgroundColor ?? AppColors.primary;
  Color get _fg => foregroundColor ?? AppColors.white;

  OutlinedBorder get _shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius));

  /// Shadow for the filled button variant.
  List<BoxShadow> get _filledShadow => [
    BoxShadow(
      color: _bg.withAlpha(70),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == ButtonVariant.filled ? _fg : _bg,
          ),
        ),
      );
    }

    final textWidget = Text(
      label,
      style: GoogleFonts.inter(
        fontSize: fontSize ?? 15,
        fontWeight: FontWeight.w600,
      ),
    );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          textWidget,
        ],
      );
    }
    return textWidget;
  }

  // ── Build ────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final child = _buildChild();
    final effectiveWidth = expand ? double.infinity : width;

    Widget button;

    switch (variant) {
      case ButtonVariant.filled:
        button = _FilledButtonWithShadow(
          onPressed: _disabled ? null : onPressed,
          bg: _bg,
          fg: _fg,
          shape: _shape,
          height: height,
          shadow: _disabled ? const [] : _filledShadow,
          child: child,
        );
        break;

      case ButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: _disabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor ?? _bg,
            disabledForegroundColor: AppColors.textHint,
            side: BorderSide(
              color: _disabled
                  ? AppColors.border
                  : (borderColor ?? foregroundColor ?? _bg),
              width: 1.5,
            ),
            shape: _shape,
            minimumSize: Size(0, height),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          child: child,
        );
        break;

      case ButtonVariant.text:
        button = TextButton(
          onPressed: _disabled ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor ?? _bg,
            disabledForegroundColor: AppColors.textHint,
            shape: _shape,
            minimumSize: Size(0, height),
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          child: child,
        );
        break;
    }

    if (effectiveWidth != null) {
      return SizedBox(width: effectiveWidth, child: button);
    }
    return button;
  }
}

// ── Internal: Filled button with drop-shadow ──────────────────

class _FilledButtonWithShadow extends StatefulWidget {
  const _FilledButtonWithShadow({
    required this.onPressed,
    required this.bg,
    required this.fg,
    required this.shape,
    required this.height,
    required this.shadow,
    required this.child,
  });

  final VoidCallback? onPressed;
  final Color bg;
  final Color fg;
  final OutlinedBorder shape;
  final double height;
  final List<BoxShadow> shadow;
  final Widget child;

  @override
  State<_FilledButtonWithShadow> createState() =>
      _FilledButtonWithShadowState();
}

class _FilledButtonWithShadowState extends State<_FilledButtonWithShadow>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final bool disabled = widget.onPressed == null;
    final Color effectiveBg = _pressed
        ? AppColors.primaryDark
        : (disabled ? widget.bg.withAlpha(80) : widget.bg);
    final Color effectiveFg = disabled
        ? AppColors.white.withAlpha(140)
        : widget.fg;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      decoration: BoxDecoration(
        boxShadow: _pressed ? const [] : widget.shadow,
        borderRadius: (widget.shape as RoundedRectangleBorder).borderRadius
            .resolve(TextDirection.ltr),
      ),
      child: ElevatedButton(
        onPressed: disabled ? null : widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBg,
          foregroundColor: effectiveFg,
          disabledBackgroundColor: widget.bg.withAlpha(80),
          disabledForegroundColor: AppColors.white.withAlpha(140),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: widget.shape,
          minimumSize: Size(0, widget.height),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        onLongPress: disabled ? null : () {},
        child: GestureDetector(
          onTapDown: disabled ? null : (_) => setState(() => _pressed = true),
          onTapUp: disabled ? null : (_) => setState(() => _pressed = false),
          onTapCancel: disabled ? null : () => setState(() => _pressed = false),
          behavior: HitTestBehavior.translucent,
          child: widget.child,
        ),
      ),
    );
  }
}
