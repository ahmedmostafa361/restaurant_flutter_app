import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/restaurant_details_screen/widget/menu_item_card.dart';

import '../../../../../config/di.dart';
import '../../../../../core/utlis/app_colors.dart';
import '../../../../../core/utlis/app_text.dart';
import '../../../../../domain/entinties/request/cart_item.dart';
import '../../../../../domain/entinties/response/menu/menu_response.dart';
import '../../../../../domain/entinties/response/restaurants/restaurant.dart';
import '../../../../../widget/animated_cart_icon_button.dart';
import '../../../../../widget/auth_resauble_widgets/fade_slide_entrance.dart';
import '../../../../../widget/toast_bar_message.dart';
import '../../cart_screen/cubit/cart_view_model.dart';
import 'cubit/restaurant_details_states.dart';
import 'cubit/restaurant_details_view_model.dart';


class RestaurantDetailsScreen extends StatelessWidget {
  const RestaurantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = ModalRoute
        .of(context)!
        .settings
        .arguments as Restaurant?;

    return BlocProvider(
      create: (_) =>
      getIt<RestaurantDetailsViewModel>()
        ..getRestaurantDetails(restaurant?.restaurantID ?? 0),
      child: _RestaurantDetailsView(fallbackRestaurant: restaurant),
    );
  }
}

class _RestaurantDetailsView extends StatefulWidget {
  final Restaurant? fallbackRestaurant;

  const _RestaurantDetailsView({this.fallbackRestaurant});

  @override
  State<_RestaurantDetailsView> createState() => _RestaurantDetailsViewState();
}

class _RestaurantDetailsViewState extends State<_RestaurantDetailsView> {
  String? _sortByPrice;

  void _toggleSort(int restaurantId) {
    final next = _sortByPrice == null
        ? 'asc'
        : _sortByPrice == 'asc'
        ? 'desc'
        : null;
    setState(() => _sortByPrice = next);
    context.read<RestaurantDetailsViewModel>().resortMenu(restaurantId, next);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<RestaurantDetailsViewModel, RestaurantDetailsStates>(
        builder: (context, state) {
          if (state is RestaurantDetailsLoadingState) {
            return const _DetailsSkeleton();
          }

          if (state is RestaurantDetailsErrorState) {
            return _ErrorView(
              message: state.errorMessage,
              onRetry: () {
                final id = widget.fallbackRestaurant?.restaurantID;
                if (id != null) {
                  context
                      .read<RestaurantDetailsViewModel>()
                      .getRestaurantDetails(id);
                }
              },
            );
          }

          final restaurant = state is RestaurantDetailsSuccessState
              ? state.restaurant
              : state is MenuSortingState
              ? state.restaurant
              : widget.fallbackRestaurant;

          final menu = state is RestaurantDetailsSuccessState
              ? state.menu
              : state is MenuSortingState
              ? state.menu
              : <MenuResponse>[];

          if (restaurant == null) {
            return _ErrorView(
              message: 'Restaurant not found.',
              onRetry: () => Navigator.of(context).pop(),
            );
          }

          return FadeSlideEntrance(
            child: CustomScrollView(
              slivers: [
                _RestaurantHeader(
                  restaurant: restaurant,
                  restaurantId: restaurant.restaurantID ?? 0,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Menu',
                          style: AppTextStyle.headline.copyWith(
                              color: AppColors.textPrimary),
                        ),
                        if (menu.isNotEmpty)
                          _SortButton(
                            sortByPrice: _sortByPrice,
                            onTap: () =>
                                _toggleSort(restaurant.restaurantID ?? 0),
                          ),
                      ],
                    ),
                  ),
                ),
                if (menu.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptyMenu(),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 24.h),
                    sliver: SliverList.separated(
                      itemCount: menu.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final item = menu[index];
                        final canAdd =
                            (item.itemName ?? '').isNotEmpty &&
                                item.itemPrice != null;

                        return MenuItemCard(
                          item: item,
                          onAdd: canAdd
                              ? () async {
                            final cart = getIt<CartViewModel>();
                            final targetRestaurantId = restaurant
                                .restaurantID ?? 0;

                            final isSwitchingRestaurant = cart
                                .currentRestaurantId != null &&
                                cart.currentRestaurantId != targetRestaurantId;

                            if (isSwitchingRestaurant) {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (dialogContext) =>
                                    AlertDialog(
                                      backgroundColor: AppColors.surface,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            16.r),
                                      ),
                                      title: Text(
                                        'Start a new order?',
                                        style: AppTextStyle.title.copyWith(
                                            color: AppColors.textPrimary),
                                      ),
                                      content: Text(
                                        'Your cart contains items from another restaurant. Adding this item will clear your existing order.',
                                        style: AppTextStyle.body.copyWith(
                                            color: AppColors.textSecondary),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(
                                                  dialogContext, false),
                                          child: Text(
                                            'Cancel',
                                            style: AppTextStyle.label.copyWith(
                                                color: AppColors.textSecondary),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(
                                                  dialogContext, true),
                                          child: Text(
                                            'Start new order',
                                            style: AppTextStyle.label.copyWith(
                                                color: AppColors.primary),
                                          ),
                                        ),
                                      ],
                                    ),
                              );

                              if (confirmed != true) return;
                              if (!context.mounted) return;
                            }

                            cart.addItem(
                              CartItem(
                                itemName: item.itemName!,
                                itemPrice: item.itemPrice!,
                                quantity: 1,
                                imageUrl: item.imageUrl,
                              ),
                              restaurantId: targetRestaurantId,
                            );

                            if (context.mounted) {
                              AppToast.success(
                                  context, '${item.itemName} added to cart');
                            }
                          }
                              : null,
                        );
                      },
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

class _RestaurantHeader extends StatelessWidget {
  final Restaurant restaurant;
  final int restaurantId;

  const _RestaurantHeader(
      {required this.restaurant, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220.h,
      pinned: true,
      backgroundColor: AppColors.secondary,
      leading: Padding(
        padding: EdgeInsets.only(left: 12.w),
        child: _CircleIconButton(
          icon: Icons.arrow_back_rounded,
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: AnimatedCartIcon(),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.secondary, AppColors.primaryDark],
                ),
              ),
            ),
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 20.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.restaurantName ?? 'Restaurant',
                    style: AppTextStyle.display.copyWith(
                        color: AppColors.surface),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if ((restaurant.type ?? '').isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Text(
                      restaurant.type!,
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.surface.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                  if ((restaurant.address ?? '').isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            color: AppColors.surface.withValues(alpha: 0.85),
                            size: 15.sp),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            restaurant.address!,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.surface.withValues(alpha: 0.85),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (restaurant.parkingLot == true) ...[
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_parking_rounded, color: AppColors
                              .surface, size: 13.sp),
                          SizedBox(width: 4.w),
                          Text('Parking available',
                              style: AppTextStyle.caption.copyWith(
                                  color: AppColors.surface)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Cart icon + live badge, reading straight from the existing CartViewModel —
/// no local/duplicate cart count.

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.25),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.surface, size: 20.sp),
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  final String? sortByPrice;
  final VoidCallback onTap;

  const _SortButton({required this.sortByPrice, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final label = switch (sortByPrice) {
      'asc' => 'Price ↑',
      'desc' => 'Price ↓',
      _ => 'Sort',
    };
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.swap_vert_rounded, size: 15.sp,
                color: AppColors.textSecondary),
            SizedBox(width: 4.w),
            Text(label, style: AppTextStyle.label.copyWith(
                color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _EmptyMenu extends StatelessWidget {
  const _EmptyMenu();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant_menu_rounded, size: 40.sp,
                color: AppColors.textTertiary),
            SizedBox(height: 12.h),
            Text(
              'No menu items available right now.',
              textAlign: TextAlign.center,
              style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
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
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: onRetry,
              child: Text('Retry',
                  style: AppTextStyle.label.copyWith(color: AppColors.primary)),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSkeleton extends StatelessWidget {
  const _DetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ShimmerBox(height: 180.h, radius: 20.r),
            SizedBox(height: 24.h),
            _ShimmerBox(height: 20.h, width: 160.w, radius: 6.r),
            SizedBox(height: 20.h),
            for (int i = 0; i < 4; i++) ...[
              _ShimmerBox(height: 84.h, radius: 16.r),
              SizedBox(height: 12.h),
            ],
          ],
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatefulWidget {
  final double height;
  final double? width;
  final double radius;

  const _ShimmerBox({required this.height, this.width, required this.radius});

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: Color.lerp(
                AppColors.divider, AppColors.border, _controller.value),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        );
      },
    );
  }
}