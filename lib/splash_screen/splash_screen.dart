import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_flutter_app/features/ui/login_screen/login_screen.dart';

import '../core/utlis/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _animationFinished = false;

  @override
  void initState() {
    super.initState();
    // Fallback timer in case onLoaded/completed never fires
    Future.delayed(const Duration(milliseconds: 3000), _goNext);
  }

  void _goNext() {
    if (!mounted || _animationFinished) return;
    _animationFinished = true;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // #FBF7F2 — matches native splash exactly
      body: Center(
        child: Lottie.network(
          'assets/animations/food_splash.json',
          width: 260,
          height: 260,
          fit: BoxFit.contain,
          repeat: false,
          onLoaded: (composition) {
            // Navigate right when the animation finishes playing
            Future.delayed(composition.duration, _goNext);
          },
        ),
      ),
    );
  }
}
