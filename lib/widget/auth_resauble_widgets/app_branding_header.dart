import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utlis/app_colors.dart';
import '../../core/utlis/app_text.dart';

/// Logo mark + app name, used at the top of Login and Register.
class AppBrandingHeader extends StatelessWidget {
  const AppBrandingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72.w,
          height: 72.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.restaurant_rounded,
            color: AppColors.surface,
            size: 34.sp,
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          'Savoria',
          style: AppTextStyle.title.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
