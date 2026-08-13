import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_flutter_app/features/ui/pages/nav_bar_screen/widget/main_bottom_nav_bar.dart';

import '../../../../config/di.dart';
import '../../../../core/utlis/app_colors.dart';
import 'cubit/wrapper_screen_states.dart';
import 'cubit/wrapper_screen_view_model.dart';

class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  final WrapperScreenViewModel viewModel = getIt<WrapperScreenViewModel>();

  // Guards against re-applying the requested tab on every rebuild —
  // didChangeDependencies can fire more than once, and we only want
  // the incoming route argument to set the tab a single time.
  bool _didApplyInitialIndex = false;

  static const _labels = ['Home', 'Orders', 'Profile'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_didApplyInitialIndex) {
      final args = ModalRoute.of(context)?.settings.arguments;

      // Callers can push this route with an int argument to land directly
      // on a specific tab, e.g. AppRoutes.mainWrapperScreen with arguments: 1
      // to open straight into Orders after placing an order.
      if (args is int && args != viewModel.selectedIndex) {
        viewModel.changeIndex(args);
      }

      _didApplyInitialIndex = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WrapperScreenViewModel, WrapperScreenStates>(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          // IndexedStack keeps each tab's scroll position / state alive
          // when switching tabs, instead of rebuilding it from scratch.
          body: IndexedStack(
            index: viewModel.selectedIndex,
            children: viewModel.selectedWidget,
          ),
          bottomNavigationBar: MainBottomNavBar(
            icons: viewModel.navIcons,
            labels: _labels,
            selectedIndex: viewModel.selectedIndex,
            onTap: viewModel.changeIndex,
          ),
        );
      },
    );
  }
}