import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/core/utlis/app_colors.dart';
import 'package:restaurant_flutter_app/core/utlis/app_text.dart';

/// Section header: a title, with an optional "View all" action.
/// Pass [onViewAllTap] as null to hide the trailing action entirely.
class RowOfTextAndViewAll extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllTap;

  const RowOfTextAndViewAll({
    super.key,
    required this.title,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: AppTextStyle.title.copyWith(color: AppColors.textPrimary)),
        if (onViewAllTap != null)
          GestureDetector(
            onTap: onViewAllTap,
            child: Text(
              'View all',
              style: AppTextStyle.label.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}