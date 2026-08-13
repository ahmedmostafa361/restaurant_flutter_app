import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utlis/app_colors.dart';
import '../../../../../core/utlis/app_routes.dart';
import '../../../../../core/utlis/app_text.dart';
import '../../../../../domain/entinties/response/orders/master_order.dart';
import '../../../../../widget/custom_elevated_button.dart';
import '../../../../../widget/resuable_cache_lottie.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final response =
        ModalRoute.of(context)!.settings.arguments as MakeOrderResponse?;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: response == null
            ? const _MissingOrderView()
            : _ConfirmationContent(response: response),
      ),
    );
  }
}

class _ConfirmationContent extends StatefulWidget {
  final MakeOrderResponse response;

  const _ConfirmationContent({required this.response});

  @override
  State<_ConfirmationContent> createState() => _ConfirmationContentState();
}

class _ConfirmationContentState extends State<_ConfirmationContent>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _entranceController, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );

    _lottieController = AnimationController(vsync: this);

    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.response.fullOrder;
    final masterId = items.isNotEmpty ? items.first.masterID : null;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
      child: Column(
        children: [
          SizedBox(
            height: 160.h,
            child: RepaintBoundary(
              child: CachedLottie(
                url:
                    'https://lottie.host/d159d4ea-169f-48a1-88bb-af502e352052/zdlEBqWjg2.json',
                height: 160.h,
                frameRate: FrameRate.composition,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Column(
                children: [
                  Text(
                    'Order Placed!',
                    style: AppTextStyle.display.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Your order has been sent to the restaurant.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  if (masterId != null) _ReferenceBadge(masterId: masterId),
                  SizedBox(height: 20.h),
                  _OrderSummaryCard(
                    items: items,
                    grandTotal: widget.response.grandTotal,
                  ),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: CustomElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.mainWrapperScreen,
                            (route) => false,
                            // Index of 'Orders' in MainWrapperScreen's tab
                            // list (Home, Orders, Profile) — lands the user
                            // on the wrapper with Orders selected, instead
                            // of pushing OrdersScreen bare with no nav bar.
                            arguments: 1,
                          ),
                      text: 'View Order',
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.mainWrapperScreen,
                          (route) => false,
                        ),
                    child: Text(
                      'Back to Home',
                      style: AppTextStyle.label.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferenceBadge extends StatelessWidget {
  final int masterId;

  const _ReferenceBadge({required this.masterId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        'Order Reference #$masterId',
        style: AppTextStyle.label.copyWith(color: AppColors.primaryDark),
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  final List<dynamic> items; // List<OrderItemResponse>
  final double? grandTotal;

  const _OrderSummaryCard({required this.items, required this.grandTotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: AppTextStyle.subtitle.copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: 12.h),
          for (final item in items) ...[
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  if (item.quantity != null)
                    Text(
                      '${item.quantity}x  ',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      item.itemName ?? '',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (item.totalPrice != null)
                    Text(
                      '\$${(item.totalPrice as double).toStringAsFixed(2)}',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                ],
              ),
            ),
          ],
          if (grandTotal != null) ...[
            Divider(color: AppColors.divider, height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: AppTextStyle.subtitle.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '\$${grandTotal!.toStringAsFixed(2)}',
                  style: AppTextStyle.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _MissingOrderView extends StatelessWidget {
  const _MissingOrderView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 40.sp,
              color: AppColors.error,
            ),
            SizedBox(height: 12.h),
            Text(
              'Order details are unavailable.',
              textAlign: TextAlign.center,
              style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.mainWrapperScreen,
                (route) => false,
              ),
              child: Text(
                'Back to Home',
                style: AppTextStyle.label.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}