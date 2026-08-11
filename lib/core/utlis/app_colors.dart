import 'package:flutter/material.dart';

/// Restaurant app color system.
///
/// Semantic, purpose-driven palette: warm terracotta as the appetite-driving
/// brand color, deep charcoal for premium contrast, muted sage reserved for
/// "fresh" moments. Background is a warm cream, not stark white, which reads
/// noticeably more premium next to food photography.
///
/// Every color maps to a real, recurring use case - nothing was added "just
/// in case." Apply colors at the call site (e.g. `AppTextStyle.title.copyWith(
/// color: AppColors.textPrimary)`), never bake them into a text style.
class AppColors {
  AppColors._();

  // ---- Brand ----
  /// CTAs, primary buttons, active nav icon/label, links
  static const Color primary = Color(0xFFD9643A);

  /// Pressed states, dark accents
  static const Color primaryDark = Color(0xFFB34F2A);

  /// Badges, subtle highlight fills, selected chip background
  static const Color primaryLight = Color(0xFFF2A98A);

  /// Premium contrast - dark buttons, hero image overlays
  static const Color secondary = Color(0xFF1F2421);

  /// "Fresh" / "Organic" tags, small highlight moments - use sparingly
  static const Color accent = Color(0xFF6B8F71);

  // ---- Surfaces ----
  /// Screen background
  static const Color background = Color(0xFFFBF7F2);

  /// Sheets, dialogs, modals, input fields
  static const Color surface = Color(0xFFFFFFFF);

  /// Restaurant / food cards (kept separate from [surface] so the two can
  /// diverge later - e.g. dark mode - without renaming call sites)
  static const Color card = Color(0xFFFFFFFF);

  // ---- Text ----
  /// Restaurant names, food names, headings
  static const Color textPrimary = Color(0xFF1C1B1A);

  /// Descriptions, secondary labels
  static const Color textSecondary = Color(0xFF6F6B66);

  /// Timestamps, captions, disabled text
  static const Color textTertiary = Color(0xFFA6A19B);

  // ---- Lines ----
  /// Input borders, card borders
  static const Color border = Color(0xFFE8E2DA);

  /// List separators
  static const Color divider = Color(0xFFF0EBE4);

  // ---- Status ----
  /// Order confirmed, delivered
  static const Color success = Color(0xFF4C9A6A);

  /// Errors, out of stock, remove-from-cart
  /// (deliberately a truer red than [primary] so the two are never confused)
  static const Color error = Color(0xFFE4483C);

  /// Delayed order, low stock
  static const Color warning = Color(0xFFE8A93A);

  /// Star ratings only
  static const Color rating = Color(0xFFF5A623);
}