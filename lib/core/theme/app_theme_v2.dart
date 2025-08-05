import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppThemeV2 {
  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);
    
    return base.copyWith(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        secondary: AppColors.primary,
        surface: AppColors.background,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      textTheme: _buildTextTheme(base.textTheme, false),
      inputDecorationTheme: _buildInputDecorationTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),
      cardTheme: _buildCardTheme(false),
      dividerTheme: _buildDividerTheme(false),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);
    
    return base.copyWith(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        secondary: AppColors.primary,
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: _buildTextTheme(base.textTheme, true),
      inputDecorationTheme: _buildInputDecorationTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),
      cardTheme: _buildCardTheme(true),
      dividerTheme: _buildDividerTheme(true),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base, bool isDark) {
    return base.copyWith(
      displayLarge: AppTextStyles.heading1.copyWith(
        color: isDark ? Colors.white : AppColors.textPrimary,
      ),
      displayMedium: AppTextStyles.heading2.copyWith(
        color: isDark ? Colors.white : AppColors.textPrimary,
      ),
      displaySmall: AppTextStyles.heading3.copyWith(
        color: isDark ? Colors.white : AppColors.textPrimary,
      ),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: isDark ? Colors.white70 : AppColors.textPrimary,
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: isDark ? Colors.white70 : AppColors.textPrimary,
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: isDark ? Colors.white54 : AppColors.textSecondary,
      ),
      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: isDark ? Colors.white : AppColors.textPrimary,
      ),
      titleMedium: AppTextStyles.titleMedium.copyWith(
        color: isDark ? Colors.white : AppColors.textPrimary,
      ),
      titleSmall: AppTextStyles.titleSmall.copyWith(
        color: isDark ? Colors.white70 : AppColors.textSecondary,
      ),
      labelLarge: AppTextStyles.labelLarge.copyWith(
        color: isDark ? Colors.white70 : AppColors.textSecondary,
      ),
      labelMedium: AppTextStyles.labelMedium.copyWith(
        color: isDark ? Colors.white54 : AppColors.textSecondary,
      ),
      labelSmall: AppTextStyles.caption.copyWith(
        color: isDark ? Colors.white54 : AppColors.textSecondary,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundSecondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      hintStyle: const TextStyle(color: AppColors.textSecondary),
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      errorStyle: const TextStyle(color: AppColors.error, fontSize: 12),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTextStyles.buttonMedium,
        elevation: 0,
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTextStyles.buttonMedium.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.buttonMedium.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }

  static CardThemeData _buildCardTheme(bool isDark) {
    return ThemeData().cardTheme.copyWith(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.border.withOpacity(isDark ? 0.3 : 0.5),
        ),
      ),
      color: isDark ? AppColors.darkSurface : Colors.white,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    );
  }

  static DividerThemeData _buildDividerTheme(bool isDark) {
    return DividerThemeData(
      color: isDark ? Colors.white24 : AppColors.border,
      thickness: 1,
      space: 1,
    );
  }
}
