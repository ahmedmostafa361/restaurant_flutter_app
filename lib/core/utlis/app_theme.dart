import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text.dart';

/// Spacing scale. Use these instead of magic numbers everywhere.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
}

/// Border radius scale.
class AppRadius {
  AppRadius._();

  /// Chips, small buttons, input fields
  static const double small = 8;

  /// Cards, buttons
  static const double medium = 12;

  /// Restaurant/food cards, bottom sheets
  static const double large = 16;

  /// Modals, hero images
  static const double extraLarge = 24;
}

/// App-wide ThemeData. Wire this into MaterialApp with `theme: AppTheme.light`.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        error: AppColors.error,
      ),

      textTheme: TextTheme(
        displayLarge: AppTextStyle.display.copyWith(
          color: AppColors.textPrimary,
        ),
        headlineMedium: AppTextStyle.headline.copyWith(
          color: AppColors.textPrimary,
        ),
        titleLarge: AppTextStyle.title.copyWith(color: AppColors.textPrimary),
        titleMedium: AppTextStyle.subtitle.copyWith(
          color: AppColors.textPrimary,
        ),
        bodyLarge: AppTextStyle.body.copyWith(color: AppColors.textPrimary),
        bodyMedium: AppTextStyle.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
        labelLarge: AppTextStyle.label.copyWith(color: AppColors.textPrimary),
        bodySmall: AppTextStyle.caption.copyWith(color: AppColors.textTertiary),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: AppTextStyle.headline.copyWith(
          color: AppColors.textPrimary,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
          side: const BorderSide(color: AppColors.border),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primaryLight,
          textStyle: AppTextStyle.label,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.lg,
            horizontal: AppSpacing.xxl,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.secondary,
          side: const BorderSide(color: AppColors.secondary),
          textStyle: AppTextStyle.label,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.lg,
            horizontal: AppSpacing.xxl,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyle.label,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: AppTextStyle.body.copyWith(color: AppColors.textTertiary),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppSpacing.lg,
          horizontal: AppSpacing.lg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.background,
        selectedColor: AppColors.primaryLight,
        labelStyle: AppTextStyle.label.copyWith(color: AppColors.textPrimary),
        side: const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        selectedLabelStyle: AppTextStyle.caption,
        unselectedLabelStyle: AppTextStyle.caption,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
