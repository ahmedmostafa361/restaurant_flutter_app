import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utlis/app_colors.dart';
import '../core/utlis/app_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderSideColor;
  final bool hasIcon;
  final Widget? customInButton;
  final EdgeInsetsGeometry? padding;

  const CustomElevatedButton({
    super.key,
    this.customInButton,
    this.hasIcon = false,
    required this.onPressed,
    this.text,
    this.textStyle,
    this.backgroundColor,
    this.borderSideColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? AppColors.primary;
    final isOnDarkBackground = effectiveBackgroundColor != AppColors.surface;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding ?? EdgeInsets.symmetric(vertical: 16.h),
        backgroundColor: effectiveBackgroundColor,
        disabledBackgroundColor: effectiveBackgroundColor.withValues(
            alpha: 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(
            color: borderSideColor ?? Colors.transparent,
            width: 1.w,
          ),
        ),
        elevation: 0,
      ),
      child: hasIcon
          ? customInButton
          : Text(
        text ?? '',
        style: textStyle ??
            AppTextStyle.title.copyWith(
              color: isOnDarkBackground
                  ? AppColors.surface
                  : AppColors.primary,
            ),
      ),
    );
  }
}