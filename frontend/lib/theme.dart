import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ──────────────────────────────────────────────────────────────
// Figma Core Colors  (UI Foundation page – Phase 1)
// ──────────────────────────────────────────────────────────────
class AppColors {
  AppColors._(); // Prevent instantiation

  // ── Primary ──────────────────────────────────────────────
  /// Primary blue – AppBar, primary buttons, focused borders, active tabs.
  static const Color primary = Color(0xFF1A56E8);

  /// Primary dark – pressed / emphasis state.
  static const Color primaryDark = Color(0xFF1435A0);

  /// Primary light – badge background, chip background.
  static const Color primaryLight = Color(0xFFD1E4FF);

  // ── Background & Surface ──────────────────────────────────
  /// Main scaffold background – pure white.
  static const Color scaffoldBg = Color(0xFFFFFFFF);

  /// Card / dialog surface – pure white.
  static const Color surface = Color(0xFFFFFFFF);

  /// Secondary surface – section grouping, list tile background.
  static const Color surfaceVariant = Color(0xFFF8FAFC);

  /// Tertiary surface – subtle divider fill, input fill.
  static const Color surfaceTertiary = Color(0xFFEFF4FB);

  // ── Text ─────────────────────────────────────────────────
  /// Near-black navy – primary headings and high-emphasis text.
  static const Color textPrimary = Color(0xFF0D1B4B);

  /// Slate grey – body text, secondary information.
  static const Color textSecondary = Color(0xFF475569);

  /// Cool grey – hints, captions, disabled labels.
  static const Color textHint = Color(0xFF94A3B8);

  // ── Border / Divider ─────────────────────────────────────
  /// Default border – enabled text field, card outline.
  static const Color border = Color(0xFFE2E8F0);

  /// Subtle divider – row separators.
  static const Color divider = Color(0xFFCBD5E1);

  // ── Accent / Semantic ────────────────────────────────────
  /// Info / sky-blue accent.
  static const Color info = Color(0xFF38BDF8);

  /// Success / confirmation green.
  static const Color success = Color(0xFF22C55E);

  /// Error / destructive red.
  static const Color error = Color(0xFFEF4444);

  // ── Legacy aliases (kept for backward-compat with call-sites) ──
  /// @deprecated Use [textPrimary].
  static const Color black = textPrimary;

  /// @deprecated Use [border].
  static const Color greyLight = border;

  /// @deprecated Use [textSecondary].
  static const Color greyMedium = textSecondary;

  /// @deprecated Use [primary].
  static const Color green = primary;

  /// Pure white shorthand.
  static const Color white = Color(0xFFFFFFFF);

  /// Warning yellow – badge, secondary accent.
  static const Color yellow = Color(0xFFF59E0B);

  /// Destructive red – kept for backward-compat.
  static const Color red = error;
}

// ──────────────────────────────────────────────────────────────
// Typography  (Figma: Poppins → Titles, Inter → Body/Caption)
// ──────────────────────────────────────────────────────────────
TextTheme _buildAppTextTheme() {
  return TextTheme(
    // ── Titles – Poppins ──────────────────────────────────
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      height: 1.25,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      height: 1.28,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      height: 1.33,
    ),
    headlineLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      height: 1.36,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.4,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.44,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.4,
      letterSpacing: 0.15,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.44,
      letterSpacing: 0.1,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.5,
    ),

    // ── Body – Inter ──────────────────────────────────────
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      height: 1.5,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      height: 1.5,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
      height: 1.5,
    ),

    // ── Label / Caption – Inter ───────────────────────────
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.primary,
      height: 1.43,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
      height: 1.33,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppColors.textHint,
      height: 1.45,
      letterSpacing: 0.5,
    ),
  );
}

// ──────────────────────────────────────────────────────────────
// App ThemeData
// ──────────────────────────────────────────────────────────────
ThemeData buildAppTheme() {
  final textTheme = _buildAppTextTheme();

  return ThemeData(
    useMaterial3: true,

    // ── Colour Scheme ────────────────────────────────────
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.scaffoldBg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.primaryLight,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.info,
      onSecondary: AppColors.white,
      error: AppColors.error,
      onError: AppColors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceVariant,
      outline: AppColors.border,
      outlineVariant: AppColors.divider,
    ),

    // ── Text ────────────────────────────────────────────
    textTheme: textTheme,

    // ── AppBar ──────────────────────────────────────────
    // Figma: dark-navy/primary blue background, white centred title.
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        height: 1.44,
      ),
    ),

    // ── ElevatedButton ──────────────────────────────────
    // Figma: 8px radius, primary blue, subtle shadow.
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.primary.withAlpha(80);
          }
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryDark;
          }
          return AppColors.primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.white.withAlpha(140);
          }
          return AppColors.white;
        }),
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) return 0;
          return 2;
        }),
        shadowColor: WidgetStateProperty.all(
          AppColors.primary.withAlpha(60),
        ),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        minimumSize: WidgetStateProperty.all(const Size(0, 48)),
      ),
    ),

    // ── OutlinedButton ──────────────────────────────────
    // Figma: 8px radius, primary blue border.
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textHint;
          }
          return AppColors.primary;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return const BorderSide(color: AppColors.border);
          }
          if (states.contains(WidgetState.pressed)) {
            return const BorderSide(color: AppColors.primaryDark, width: 1.5);
          }
          return const BorderSide(color: AppColors.primary);
        }),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
        minimumSize: WidgetStateProperty.all(const Size(0, 48)),
      ),
    ),

    // ── TextButton ──────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textHint;
          }
          return AppColors.primary;
        }),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    ),

    // ── InputDecoration ─────────────────────────────────
    // Figma: 8px radius, border #E2E8F0, focused 2px primary blue.
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceTertiary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      hintStyle: GoogleFonts.inter(
        color: AppColors.textHint,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: GoogleFonts.inter(
        color: AppColors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelStyle: GoogleFonts.inter(
        color: AppColors.primary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      errorStyle: GoogleFonts.inter(
        color: AppColors.error,
        fontSize: 12,
      ),
    ),

    // ── Divider ─────────────────────────────────────────
    dividerColor: AppColors.divider,
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    // ── Card ────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 2,
      shadowColor: AppColors.primary.withAlpha(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
    ),

    // ── Icon ────────────────────────────────────────────
    iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 24),
    primaryIconTheme: const IconThemeData(color: AppColors.white, size: 24),
  );
}

/// Global [ThemeData] instance – use in [MaterialApp.theme].
final ThemeData appTheme = buildAppTheme();
