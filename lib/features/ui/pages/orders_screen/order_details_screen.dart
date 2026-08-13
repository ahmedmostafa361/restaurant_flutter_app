import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/di.dart';
import '../../../../core/utlis/app_colors.dart';
import '../../../../core/utlis/app_text.dart';
import '../../../../domain/entinties/response/orders/order_details.dart';
import '../../../../widget/auth_resauble_widgets/fade_slide_entrance.dart';
import '../../../../widget/toast_bar_message.dart';
import 'cubit/order_details_screen_states.dart';
import 'cubit/order_details_screen_view_model.dart';


class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final masterId = ModalRoute
        .of(context)!
        .settings
        .arguments as int?;

    return BlocProvider(
      create: (_) =>
      getIt<OrderDetailsScreenViewModel>()
        ..getOrderDetails(masterId ?? 0),
      child: _OrderDetailsView(masterId: masterId),
    );
  }
}

class _OrderDetailsView extends StatelessWidget {
  final int? masterId;

  const _OrderDetailsView({required this.masterId});

  Future<void> _confirmDeleteItem(BuildContext context,
      OrderDetails item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) =>
          AlertDialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            title: Text('Remove item?', style: AppTextStyle.title.copyWith(
                color: AppColors.textPrimary)),
            content: Text(
              'Remove "${item.itemName ?? 'this item'}" from the order?',
              style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text('Cancel', style: AppTextStyle.label.copyWith(
                    color: AppColors.textSecondary)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text('Remove',
                    style: AppTextStyle.label.copyWith(color: AppColors.error)),
              ),
            ],
          ),
    );

    if (!context.mounted) return;
    if (confirmed == true && item.orderID != null) {
      context.read<OrderDetailsScreenViewModel>().deleteOrderItem(
          item.orderID!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          masterId != null ? 'Order #$masterId' : 'Order Details',
          style: AppTextStyle.title.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: BlocConsumer<OrderDetailsScreenViewModel, OrderDetailsScreenStates>(
        listener: (context, state) {
          if (state is OrderDetailsScreenDeleteSuccessState) {
            AppToast.success(context, 'Item removed.');
            // Reuse the existing fetch method to reflect the change —
            // no separate refresh mechanism.
            context.read<OrderDetailsScreenViewModel>().getOrderDetails(
                masterId ?? 0);
          } else if (state is OrderDetailsScreenErrorState) {
            AppToast.error(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is OrderDetailsScreenLoadingState ||
              state is OrderDetailsScreenInitialState) {
            return const _DetailsSkeleton();
          }

          if (state is OrderDetailsScreenErrorState) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline_rounded, size: 40.sp,
                        color: AppColors.error),
                    SizedBox(height: 12.h),
                    Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.body.copyWith(
                          color: AppColors.textSecondary),
                    ),
                    SizedBox(height: 20.h),
                    TextButton(
                      onPressed: () =>
                          context
                              .read<OrderDetailsScreenViewModel>()
                              .getOrderDetails(masterId ?? 0),
                      child: Text('Retry',
                          style: AppTextStyle.label.copyWith(color: AppColors
                              .primary)),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is! OrderDetailsScreenSuccessState) {
            return const SizedBox.shrink();
          }

          final items = state.orderDetails;
          if (items.isEmpty) {
            return Center(
              child: Text(
                'No items found for this order.',
                style: AppTextStyle.body.copyWith(
                    color: AppColors.textSecondary),
              ),
            );
          }

          final total = items.fold<double>(
              0, (sum, i) => sum + (i.totalPrice ?? 0));

          return FadeSlideEntrance(
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
              children: [
                Text('Items', style: AppTextStyle.headline.copyWith(
                    color: AppColors.textPrimary)),
                SizedBox(height: 12.h),
                for (final item in items) ...[
                  _OrderItemRow(item: item,
                      onDelete: () => _confirmDeleteItem(context, item)),
                  SizedBox(height: 10.h),
                ],
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTextStyle.subtitle.copyWith(
                          color: AppColors.textSecondary)),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: AppTextStyle.title.copyWith(
                            color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final OrderDetails item;
  final VoidCallback onDelete;

  const _OrderItemRow({required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.itemName ?? '', style: AppTextStyle.subtitle.copyWith(
                    color: AppColors.textPrimary)),
                if (item.quantity != null && item.itemPrice != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    '${item.quantity} × \$${item.itemPrice!.toStringAsFixed(
                        2)}',
                    style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          if (item.totalPrice != null)
            Text(
              '\$${item.totalPrice!.toStringAsFixed(2)}',
              style: AppTextStyle.price.copyWith(color: AppColors.textPrimary),
            ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete_outline_rounded, color: AppColors.error,
                size: 20.sp),
          ),
        ],
      ),
    );
  }
}

class _DetailsSkeleton extends StatelessWidget {
  const _DetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < 4; i++) ...[
            Container(
              height: 64.h,
              decoration: BoxDecoration(color: AppColors.divider,
                  borderRadius: BorderRadius.circular(14.r)),
            ),
            SizedBox(height: 10.h),
          ],
        ],
      ),
    );
  }
}