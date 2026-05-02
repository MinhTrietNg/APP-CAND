import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

/// Loading spinner dùng chung – lấy màu [AppColors.primary] từ Design System.
///
/// ```dart
/// // Spinner mặc định (inline, centered)
/// const LoadingIndicator()
///
/// // Toàn màn hình với overlay mờ
/// LoadingIndicator.overlay()
///
/// // Inline với thông báo
/// LoadingIndicator(message: 'Đang tải...')
/// ```
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.size = 36,
    this.strokeWidth = 3.0,
    this.color,
    this.message,
  }) : _overlay = false;

  /// Hiển thị spinner giữa màn hình với nền mờ.
  const LoadingIndicator.overlay({
    super.key,
    this.size = 44,
    this.strokeWidth = 3.5,
    this.color,
    this.message,
  }) : _overlay = true;

  /// Kích thước spinner (mặc định 36 px – khớp Figma standard).
  final double size;

  /// Độ dày nét vẽ (mặc định 3.0).
  final double strokeWidth;

  /// Ghi đè màu spinner (mặc định [AppColors.primary]).
  final Color? color;

  /// Thông báo hiển thị bên dưới spinner (tuỳ chọn).
  final String? message;

  final bool _overlay;

  @override
  Widget build(BuildContext context) {
    final spinnerColor = color ?? AppColors.primary;

    final spinner = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
            backgroundColor: spinnerColor.withAlpha(30),
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 14),
          Text(
            message!,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: _overlay ? AppColors.white : AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (!_overlay) {
      return Center(child: spinner);
    }

    // ── Full-screen overlay ──
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.black.withAlpha(120),
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: spinner,
        ),
      ),
    );
  }
}
