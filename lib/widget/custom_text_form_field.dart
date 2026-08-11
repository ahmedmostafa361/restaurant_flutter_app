import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utlis/app_colors.dart';
import '../core/utlis/app_text.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? borderSideColor;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final String obscuringCharacter;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    this.fillColor,
    this.controller,
    this.maxLines,
    this.borderSideColor,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.obscuringCharacter = '*',
    this.suffixIcon,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderSideColor ?? AppColors.border;

    return TextFormField(
      style: style ?? AppTextStyle.body.copyWith(color: AppColors.textPrimary),
      maxLines: obscureText ? 1 : (maxLines ?? 1),
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      obscuringCharacter: obscuringCharacter,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        border: _outlineInputBorder(effectiveBorderColor),
        enabledBorder: _outlineInputBorder(effectiveBorderColor),
        focusedBorder: _outlineInputBorder(AppColors.primary, width: 1.5),
        errorBorder: _outlineInputBorder(AppColors.error),
        focusedErrorBorder: _outlineInputBorder(AppColors.error, width: 1.5),
        fillColor: fillColor ?? AppColors.surface,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        hintText: hintText,
        hintStyle:
            hintStyle ??
            AppTextStyle.body.copyWith(color: AppColors.textTertiary),
        labelText: labelText,
        labelStyle:
            labelStyle ??
            AppTextStyle.body.copyWith(color: AppColors.textSecondary),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: color, width: width.w),
    );
  }
}