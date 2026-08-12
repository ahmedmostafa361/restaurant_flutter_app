import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_flutter_app/core/utlis/app_colors.dart';
import 'package:shimmer/shimmer.dart';

/// Skeleton loading state shaped like the restaurant list, instead of a
/// generic spinner, per the design spec.
class MainLoadingWidget extends StatelessWidget {
  const MainLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.border,
      highlightColor: AppColors.background,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        itemCount: 5,
        separatorBuilder: (_, __) => SizedBox(height: 14.h),
        itemBuilder: (_, __) => Container(
          height: 92.h,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }
}