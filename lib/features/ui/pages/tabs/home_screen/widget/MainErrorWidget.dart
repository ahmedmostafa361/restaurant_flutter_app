import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/core/utlis/app_colors.dart';
import 'package:restaurant_flutter_app/core/utlis/app_text.dart';
import 'package:restaurant_flutter_app/core/utlis/app_theme.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onPressed;

  const MainErrorWidget({
    super.key,
    required this.errorMessage,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
                Icons.error_outline_rounded, color: AppColors.error, size: 48),
            const SizedBox(height: AppSpacing.md),
            Text(
              errorMessage,
              style: AppTextStyle.subtitle.copyWith(
                  color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            if (onPressed != null) ...[
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: Text('Try Again', style: AppTextStyle.label.copyWith(
                    color: AppColors.surface)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}