import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Restaurant app typography system.
///
/// Styles are named for what the text IS ([title], [price], [caption]...)
/// instead of what it looks like (`bold16White`). That's what keeps this
/// file from growing into 40+ near-duplicate styles the way the old one did.
///
/// Color is intentionally NOT baked in here - apply it at the call site with
/// `.copyWith(color: AppColors.x)`. This keeps typography and palette fully
/// decoupled, so a palette change (like this one) never touches this file.
///
/// Font: Plus Jakarta Sans - modern, geometric, reads premium, and has clean
/// numeral shapes that suit price tags. If you'd rather keep Poppins (already
/// used in the old file), just swap `GoogleFonts.plusJakartaSans` for
/// `GoogleFonts.poppins` below - everything else stays the same.
class AppTextStyle {
  AppTextStyle._();

  /// Onboarding, splash, empty-state headline
  static final TextStyle display = GoogleFonts.plusJakartaSans(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  /// Screen titles - "Checkout", "Your orders"
  static final TextStyle headline = GoogleFonts.plusJakartaSans(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  /// Restaurant name, section titles
  static final TextStyle title = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  /// Food name, address line
  static final TextStyle subtitle = GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.35,
  );

  /// Descriptions, general body copy
  static final TextStyle body = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Secondary descriptions, form helper text
  static final TextStyle bodySmall = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// Button text, nav labels, chip text
  static final TextStyle label = GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  /// Timestamps, metadata
  static final TextStyle caption = GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  /// Prices - bold enough to stand apart from surrounding body text
  static final TextStyle price = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
}