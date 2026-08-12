import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_flutter_app/core/utlis/app_colors.dart';
import 'package:restaurant_flutter_app/core/utlis/app_text.dart';

/// No user/profile data currently exists in this app's state, so this
/// stays informational rather than faking a name or avatar.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Icon(
            Icons.restaurant_rounded,
            color: AppColors.surface,
            size: 22.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Savoria',
                style: AppTextStyle.title.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Discover restaurants near you',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
