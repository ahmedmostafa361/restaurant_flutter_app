import 'package:flutter/material.dart';
import 'package:restaurant_flutter_app/features/ui/login_screen/login_screen.dart';

import '../core/utlis/app_colors.dart';
import '../widget/resuable_cache_lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _splashLottieUrl =
      'https://lottie.host/8a3ad046-498e-436d-b272-850ddd65de6e/Fa3sMSVlq8.json';

  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    // Fallback in case onLoaded never fires (e.g. no cache + dead network)
    Future.delayed(const Duration(milliseconds: 3000), _goNext);
  }

  void _goNext() {
    if (!mounted || _navigated) return;
    _navigated = true;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: CachedLottie(
          url: _splashLottieUrl,
          width: 260,
          height: 260,
          fit: BoxFit.contain,
          repeat: false,
          onLoaded: (composition) {
            // Cached path fires this instantly, so the splash won't
            // sit around waiting on a network round-trip that already happened.
            Future.delayed(composition.duration, _goNext);
          },
        ),
      ),
    );
  }
}