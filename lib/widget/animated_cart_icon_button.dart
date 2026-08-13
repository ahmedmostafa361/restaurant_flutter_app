import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/di.dart';
import '../core/utlis/app_colors.dart';
import '../core/utlis/app_routes.dart';
import '../core/utlis/app_text.dart';
import '../features/ui/pages/cart_screen/cubit/cart_states.dart';
import '../features/ui/pages/cart_screen/cubit/cart_view_model.dart';

class AnimatedCartIcon extends StatefulWidget {
  const AnimatedCartIcon({super.key});

  @override
  State<AnimatedCartIcon> createState() => _AnimatedCartIconState();
}

class _AnimatedCartIconState extends State<AnimatedCartIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _jumpAnimation;
  int _previousCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.3,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.3,
          end: 0.9,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.9,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
    ]).animate(_controller);

    _jumpAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: -8.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -8.0,
          end: 2.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 2.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartViewModel, CartStates>(
      bloc: getIt<CartViewModel>(),
      listenWhen: (previous, current) => current is CartUpdatedState,
      listener: (context, state) {
        final count = state is CartUpdatedState
            ? state.items.fold<int>(0, (sum, i) => sum + i.quantity)
            : 0;
        // Only pulse on a genuine increase — not on decrement, remove, or
        // the clear-and-restart that happens when switching restaurants.
        if (count > _previousCount) {
          _controller.forward(from: 0);
        }
        _previousCount = count;
      },
      builder: (context, state) {
        final count = state is CartUpdatedState
            ? state.items.fold<int>(0, (sum, i) => sum + i.quantity)
            : 0;

        return InkWell(
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.cartScreen),
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 44.w,
            height: 44.w,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _jumpAnimation.value),
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColors.surface,
                      size: 20.sp,
                    ),
                  ),
                  Positioned(
                    top: -2.h,
                    right: -4.w,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.elasticOut,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                      child: count > 0
                          ? Container(
                              key: ValueKey<int>(count),
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 1.h,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 17.w,
                                minHeight: 17.w,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: AppColors.surface,
                                  width: 1.2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                count > 99 ? '99+' : '$count',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.caption.copyWith(
                                  color: AppColors.surface,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10.sp,
                                  height: 1,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(key: ValueKey('empty-badge')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
