import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_flutter_app/features/ui/pages/orders_screen/widget/order_card.dart';
import 'package:restaurant_flutter_app/widget/resuable_cache_lottie.dart';

import '../../../../config/di.dart';
import '../../../../core/utlis/app_colors.dart';
import '../../../../core/utlis/app_routes.dart';
import '../../../../core/utlis/app_text.dart';
import '../../../../widget/auth_resauble_widgets/fade_slide_entrance.dart';
import '../../../../widget/custom_elevated_button.dart';
import 'cubit/orders_history_states.dart';
import 'cubit/orders_history_view_model.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      getIt<OrdersHistoryViewModel>()
        ..getOrders(),
      child: const _OrdersView(),
    );
  }
}

class _OrdersView extends StatelessWidget {
  const _OrdersView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Your Orders',
            style: AppTextStyle.title.copyWith(color: AppColors.textPrimary)),
      ),
      body: BlocBuilder<OrdersHistoryViewModel, OrdersHistoryStates>(
        builder: (context, state) {
          if (state is OrdersHistoryLoadingState ||
              state is OrdersHistoryInitialState) {
            return const _OrdersSkeleton();
          }

          if (state is OrdersHistoryNotAuthenticatedState) {
            return _MessageView(
              icon: Icons.lock_outline_rounded,
              message: 'Please log in to see your orders.',
              actionLabel: 'Go to Login',
              onAction: () =>
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                      AppRoutes.loginScreen, (route) => false),
            );
          }

          if (state is OrdersHistoryErrorState) {
            return _MessageView(
              icon: Icons.error_outline_rounded,
              message: state.errorMessage,
              actionLabel: 'Retry',
              onAction: () =>
                  context.read<OrdersHistoryViewModel>().getOrders(),
            );
          }

          if (state is OrdersHistoryEmptyState) {
            return _EmptyOrdersView(
              onStartOrdering: () =>
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                      AppRoutes.mainWrapperScreen, (route) => false),
            );
          }

          final orders = (state as OrdersHistorySuccessState).orders;

          return FadeSlideEntrance(
            child: ListView.separated(
              padding: EdgeInsets.all(20.w),
              itemCount: orders.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(
                  order: order,
                  onTap: order.masterID == null
                      ? null
                      : () =>
                      Navigator.of(context).pushNamed(
                        AppRoutes.orderDetailsScreen,
                        arguments: order.masterID,
                      ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/// Used for error and not-authenticated states — static icon, no animation,
/// since those aren't moments that call for warmth/motion.
class _MessageView extends StatelessWidget {
  final IconData icon;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  const _MessageView({
    required this.icon,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44.sp, color: AppColors.textTertiary),
            SizedBox(height: 14.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(onPressed: onAction, text: actionLabel),
          ],
        ),
      ),
    );
  }
}

/// Empty-orders state — the one spot in this phase where a Lottie animation
/// fits, since it's an idle/ambient screen rather than an error or a
/// one-time success moment. Falls back to a static icon if the asset isn't
/// present yet or fails to render.
class _EmptyOrdersView extends StatelessWidget {
  final VoidCallback onStartOrdering;

  const _EmptyOrdersView({required this.onStartOrdering});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 140.h,
                child: CachedLottie(
                    url: 'https://lottie.host/e360b63e-493f-433e-98c8-f0b422c1d26f/kI6FpCAg2y.json')
            ),
            SizedBox(height: 8.h),
            Text('No orders yet', style: AppTextStyle.title.copyWith(
                color: AppColors.textPrimary)),
            SizedBox(height: 6.h),
            Text(
              'When you place an order, it will show up here.',
              textAlign: TextAlign.center,
              style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
                onPressed: onStartOrdering, text: 'Start Ordering'),
          ],
        ),
      ),
    );
  }
}

class _OrdersSkeleton extends StatelessWidget {
  const _OrdersSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(20.w),
      itemCount: 5,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, __) => _ShimmerBar(height: 72.h),
    );
  }
}

class _ShimmerBar extends StatefulWidget {
  final double height;

  const _ShimmerBar({required this.height});

  @override
  State<_ShimmerBar> createState() => _ShimmerBarState();
}

class _ShimmerBarState extends State<_ShimmerBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100))
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
      builder: (context, child) =>
          Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: Color.lerp(
                  AppColors.divider, AppColors.border, _controller.value),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
    );
  }
}