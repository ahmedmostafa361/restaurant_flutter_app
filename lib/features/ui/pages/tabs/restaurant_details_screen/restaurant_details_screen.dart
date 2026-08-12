import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/core/utlis/app_colors.dart';
import 'package:restaurant_flutter_app/core/utlis/app_text.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';

/// Was an empty Placeholder with no way to receive the tapped restaurant.
/// This adds only the plumbing to read it from route arguments — the full
/// details UI is a future phase, not implemented here.
class RestaurantDetailsScreen extends StatelessWidget {
  const RestaurantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = ModalRoute
        .of(context)!
        .settings
        .arguments as Restaurant?;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          restaurant?.restaurantName ?? 'Restaurant',
          style: AppTextStyle.title.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: const Center(
          child: Text('Restaurant details — coming in a future phase')),
    );
  }
}