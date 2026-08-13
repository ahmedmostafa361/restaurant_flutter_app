import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utlis/app_colors.dart';
import '../../../../../core/utlis/app_text.dart';
import '../../../../../domain/entinties/response/orders/order_history_details.dart';

class OrderCard extends StatelessWidget {
  final OrderDetailsHistory order;
  final VoidCallback? onTap;

  const OrderCard({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                    Icons.receipt_long_rounded, color: AppColors.primaryDark,
                    size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.masterID != null
                          ? 'Order #${order.masterID}'
                          : 'Order',
                      style: AppTextStyle.subtitle.copyWith(
                          color: AppColors.textPrimary),
                    ),
                    if (order.restaurantID != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        'Restaurant #${order.restaurantID}',
                        style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.textSecondary),
                      ),
                    ],
                  ],
                ),
              ),
              if (order.grandTotal != null)
                Text(
                  '\$${order.grandTotal!.toStringAsFixed(2)}',
                  style: AppTextStyle.price.copyWith(
                      color: AppColors.textPrimary),
                ),
              SizedBox(width: 6.w),
              Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary,
                  size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}