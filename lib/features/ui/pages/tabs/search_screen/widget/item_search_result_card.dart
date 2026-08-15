import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utlis/app_colors.dart';
import '../../../../../../core/utlis/app_text.dart';
import '../../../../../../domain/entinties/response/menu/menu_item.dart';


class ItemSearchResultCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  const ItemSearchResultCard({
    super.key,
    required this.item,
    this.onTap,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = (item.imageUrl ?? '').isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: hasImage
                    ? Image.network(
                  item.imageUrl!,
                  width: 76.w,
                  height: 76.w,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _imageFallback(),
                )
                    : _imageFallback(),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.itemName ?? '',
                      style: AppTextStyle.subtitle.copyWith(
                          color: AppColors.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if ((item.restaurantName ?? '').isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(Icons.storefront_rounded, size: 13.sp,
                              color: AppColors.textTertiary),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              item.restaurantName!,
                              style: AppTextStyle.caption.copyWith(
                                  color: AppColors.textTertiary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if ((item.itemDescription ?? '').isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        item.itemDescription!,
                        style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.textSecondary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (item.itemPrice != null)
                          Text(
                            '\$${item.itemPrice!.toStringAsFixed(2)}',
                            style: AppTextStyle.price.copyWith(color: AppColors
                                .textPrimary),
                          ),
                        if (onAdd != null)
                          InkWell(
                            onTap: onAdd,
                            borderRadius: BorderRadius.circular(10.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 7.h),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text('Add',
                                  style: AppTextStyle.label.copyWith(
                                      color: AppColors.surface)),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageFallback() {
    return Container(
      width: 76.w,
      height: 76.w,
      color: AppColors.divider,
      alignment: Alignment.center,
      child: Icon(Icons.restaurant_menu_rounded, color: AppColors.textTertiary,
          size: 26.sp),
    );
  }
}