import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_flutter_app/features/ui/pages/cart_screen/widget/cart_item_widget.dart';

import '../../../../config/di.dart';
import '../../../../core/utlis/app_colors.dart';
import '../../../../core/utlis/app_routes.dart';
import '../../../../core/utlis/app_text.dart';
import '../../../../domain/entinties/request/make_order_request.dart';
import '../../../../domain/entinties/request/order_item_request.dart';
import '../../../../widget/auth_resauble_widgets/fade_slide_entrance.dart';
import '../../../../widget/custom_elevated_button.dart';
import '../../../../widget/toast_bar_message.dart';
import 'cubit/cart_states.dart';
import 'cubit/cart_view_model.dart';
import 'cubit/place_order_states.dart';
import 'cubit/place_order_view_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PlaceOrderViewModel>(),
      child: const _CartView(),
    );
  }
}

class _CartView extends StatelessWidget {
  const _CartView();

  Future<void> _confirmClearCart(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) =>
          AlertDialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            title: Text('Clear cart?', style: AppTextStyle.title.copyWith(
                color: AppColors.textPrimary)),
            content: Text(
              'This will remove all items from your cart.',
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
                child: Text('Clear',
                    style: AppTextStyle.label.copyWith(color: AppColors.error)),
              ),
            ],
          ),
    );
    if (confirmed == true) {
      getIt<CartViewModel>().clearCart();
    }
  }

  void _placeOrder(BuildContext context, CartUpdatedState cartState) {
    final request = MakeOrderRequest(
      restaurantId: getIt<CartViewModel>().currentRestaurantId ?? 0,
      items: cartState.items
          .map((i) =>
          OrderItemRequest(itemName: i.itemName, quantity: i.quantity.toInt()))
          .toList(),
    );
    context.read<PlaceOrderViewModel>().placeOrder(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<PlaceOrderViewModel, PlaceOrderStates>(
          listener: (context, orderState) {
            if (orderState is PlaceOrderSuccessState) {
              getIt<CartViewModel>().clearCart();
              AppToast.success(context, 'Order placed successfully!');
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(
                  AppRoutes.ordersScreen, (route) => false);
            } else if (orderState is PlaceOrderErrorState) {
              AppToast.error(context, orderState.errorMessage);
            }
          },
          builder: (context, orderState) {
            final isPlacingOrder = orderState is PlaceOrderLoadingState;

            return BlocBuilder<CartViewModel, CartStates>(
              bloc: getIt<CartViewModel>(),
              builder: (context, cartState) {
                final items = cartState is CartUpdatedState
                    ? cartState.items
                    : const [];

                // Fixed line: converted i.quantity to int
                final itemCount = items.fold<num>(
                    0, (sum, i) => sum + i.quantity).toInt();
                return FadeSlideEntrance(
                  child: Column(
                    children: [
                      _CartAppBar(
                        itemCount: itemCount,
                        onClear: items.isEmpty ? null : () =>
                            _confirmClearCart(context),
                      ),
                      Expanded(
                        child: items.isEmpty
                            ? const _EmptyCart()
                            : ListView.builder(
                          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return CartItemWidget(
                              item: item,
                              onIncrement: () =>
                                  getIt<CartViewModel>().incrementQuantity(
                                      item.itemName),
                              onDecrement: () =>
                                  getIt<CartViewModel>().decrementQuantity(
                                      item.itemName),
                              onRemove: () =>
                                  getIt<CartViewModel>().removeItem(
                                      item.itemName),
                            );
                          },
                        ),
                      ),
                      if (items.isNotEmpty && cartState is CartUpdatedState)
                        _OrderSummaryBar(
                          total: cartState.totalPrice,
                          isLoading: isPlacingOrder,
                          onPlaceOrder: isPlacingOrder
                              ? () {}
                              : () => _placeOrder(context, cartState),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _CartAppBar extends StatelessWidget {
  final int itemCount;
  final VoidCallback? onClear;

  const _CartAppBar({required this.itemCount, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 20.w, 8.h),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            customBorder: const CircleBorder(),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Icon(
                  Icons.arrow_back_rounded, color: AppColors.textPrimary,
                  size: 22.sp),
            ),
          ),
          SizedBox(width: 4.w),
          Text('Cart', style: AppTextStyle.headline.copyWith(
              color: AppColors.textPrimary)),
          if (itemCount > 0) ...[
            SizedBox(width: 8.w),
            Text('($itemCount)', style: AppTextStyle.body.copyWith(
                color: AppColors.textSecondary)),
          ],
          const Spacer(),
          if (onClear != null)
            TextButton(
              onPressed: onClear,
              child: Text('Clear',
                  style: AppTextStyle.label.copyWith(color: AppColors.error)),
            ),
        ],
      ),
    );
  }
}

class _OrderSummaryBar extends StatelessWidget {
  final double total;
  final bool isLoading;
  final VoidCallback onPlaceOrder;

  const _OrderSummaryBar({
    required this.total,
    required this.isLoading,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTextStyle.subtitle.copyWith(
                  color: AppColors.textSecondary)),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) =>
                    FadeTransition(opacity: anim, child: child),
                child: Text(
                  '\$${total.toStringAsFixed(2)}',
                  key: ValueKey(total),
                  style: AppTextStyle.headline.copyWith(
                      color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          SizedBox(
            height: 54.h,
            width: double.infinity,
            child: CustomElevatedButton(
              onPressed: isLoading ? null : onPlaceOrder,
              hasIcon: isLoading,
              customInButton: SizedBox(
                width: 22.w,
                height: 22.h,
                child: CircularProgressIndicator(
                    strokeWidth: 2.4, color: AppColors.surface),
              ),
              text: 'Place Order',
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88.w,
              height: 88.w,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shopping_cart_outlined, size: 38.sp,
                  color: AppColors.primaryDark),
            ),
            SizedBox(height: 18.h),
            Text('Your cart is empty', style: AppTextStyle.title.copyWith(
                color: AppColors.textPrimary)),
            SizedBox(height: 6.h),
            Text(
              'Add items from a restaurant to get started.',
              textAlign: TextAlign.center,
              style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                onPressed: () =>
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(
                        AppRoutes.mainWrapperScreen, (route) => false),
                text: 'Browse Restaurants',
              ),
            ),
          ],
        ),
      ),
    );
  }
}