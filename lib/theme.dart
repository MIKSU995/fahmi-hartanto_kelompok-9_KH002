import 'package:flutter/material.dart';

/// Palet mengikuti Figma: latar hitam hangat, kartu abu gelap, aksen emas.
class AppColors {
  static const Color bg = Color(0xFF0F1110);
  static const Color surface = Color(0xFF181A19);
  static const Color surfaceAlt = Color(0xFF212423);
  static const Color border = Color(0xFF2C2F2D);

  static const Color ink = Color(0xFFF1EEE6);
  static const Color muted = Color(0xFF9B9D98);

  static const Color gold = Color(0xFFD9BE80);
  static const Color goldSoft = Color(0xFF332C1B);
  static const Color onGold = Color(0xFF1A1508);

  static const Color success = Color(0xFF6FCF97);
  static const Color successSoft = Color(0xFF1B3629);
  static const Color danger = Color(0xFFE08080);
  static const Color dangerSoft = Color(0xFF3A2424);

  // Alias agar kode lama tetap valid.
  static const Color primary = gold;
  static const Color primarySoft = goldSoft;
  static const Color warning = gold;
  static const Color warningSoft = goldSoft;
}

class AppTheme {
  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.gold,
        onPrimary: AppColors.onGold,
        secondary: AppColors.gold,
        surface: AppColors.surface,
        onSurface: AppColors.ink,
        error: AppColors.danger,
      ),
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.surfaceAlt,
        contentTextStyle: TextStyle(color: AppColors.ink),
        behavior: SnackBarBehavior.floating,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceAlt,
        hintStyle: const TextStyle(color: AppColors.muted),
        prefixIconColor: AppColors.muted,
        suffixIconColor: AppColors.muted,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: _border(AppColors.border),
        enabledBorder: _border(AppColors.border),
        focusedBorder: _border(AppColors.gold, 1.5),
        errorBorder: _border(AppColors.danger),
        focusedErrorBorder: _border(AppColors.danger, 1.5),
      ),
    );
  }

  static OutlineInputBorder _border(Color c, [double w = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: c, width: w),
      );
}