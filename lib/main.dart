import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/di.dart';
import 'core/cache_save_data/lottie_animation_cache_manager.dart';
import 'core/utlis/app_routes.dart';
import 'features/ui/login_screen/login_screen.dart';
import 'features/ui/pages/cart_screen/cart_screen.dart';
import 'features/ui/pages/cart_screen/widget/order_confirmation_screen.dart';
import 'features/ui/pages/nav_bar_screen/main_wrapper_screen.dart';
import 'features/ui/pages/orders_screen/order_details_screen.dart';
import 'features/ui/pages/orders_screen/orders_screen.dart';
import 'features/ui/pages/tabs/home_screen/home_screen.dart';
import 'features/ui/pages/tabs/profile_screen/profile_screen.dart';
import 'features/ui/pages/tabs/restaurant_details_screen/restaurant_details_screen.dart';
import 'features/ui/pages/tabs/search_screen/search_screen.dart';
import 'features/ui/register_screen/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await LottieCacheManager().preloadAllNetwork([
    'https://lottie.host/d159d4ea-169f-48a1-88bb-af502e352052/zdlEBqWjg2.json',
    // Add other critical network JSON URLs here
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.loginScreen,
          routes: {
            // Auth
            AppRoutes.loginScreen: (context) => const LoginScreen(),
            AppRoutes.registerScreen: (context) => const RegisterScreen(),

            // Main Navigation Wrapper
            AppRoutes.mainWrapperScreen: (context) => const MainWrapperScreen(),

            // Tabs & Screens
            AppRoutes.homeScreen: (context) => const HomeScreen(),
            AppRoutes.restaurantDetailsScreen: (context) =>
                const RestaurantDetailsScreen(),
            AppRoutes.searchScreen: (context) => const SearchScreen(),
            AppRoutes.profileScreen: (context) => const ProfileScreen(),

            // Cart & Orders
            AppRoutes.cartScreen: (context) => const CartScreen(),
            AppRoutes.ordersScreen: (context) => const OrdersScreen(),
            AppRoutes.orderDetailsScreen: (context) =>
                const OrderDetailsScreen(),
            AppRoutes.orderConfirmationScreen: (context) =>
                const OrderConfirmationScreen(),
          },
        );
      },
    );
  }
}