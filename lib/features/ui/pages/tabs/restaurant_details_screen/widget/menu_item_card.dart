import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utlis/app_colors.dart';
import '../../../../../../core/utlis/app_text.dart';
import '../../../../../../domain/entinties/response/menu/menu_response.dart';

class MenuItemCard extends StatelessWidget {
  final MenuResponse item;
  final VoidCallback? onAdd;

  const MenuItemCard({super.key, required this.item, this.onAdd});

  @override
  Widget build(BuildContext context) {
    final hasImage = (item.imageUrl ?? '').isNotEmpty;

    return Container(
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
              width: 84.w,
              height: 84.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _imageFallback(),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return _imageFallback(loading: true);
              },
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
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (item.itemPrice != null)
                      Text(
                        '\$${item.itemPrice!.toStringAsFixed(2)}',
                        style: AppTextStyle.price.copyWith(
                            color: AppColors.textPrimary),
                      ),
                    _AddButton(onPressed: onAdd),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageFallback({bool loading = false}) {
    return Container(
      width: 84.w,
      height: 84.w,
      color: AppColors.divider,
      alignment: Alignment.center,
      child: loading
          ? SizedBox(
        width: 18.w,
        height: 18.w,
        child: CircularProgressIndicator(
            strokeWidth: 2, color: AppColors.primary),
      )
          : Icon(Icons.restaurant_menu_rounded, color: AppColors.textTertiary,
          size: 28.sp),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _AddButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          'Add',
          style: AppTextStyle.label.copyWith(color: AppColors.surface),
        ),
      ),
    );
  }
}