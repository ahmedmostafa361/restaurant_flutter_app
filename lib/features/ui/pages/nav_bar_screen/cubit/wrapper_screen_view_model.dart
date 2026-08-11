import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/features/ui/pages/orders_screen/orders_screen.dart';

import '../../../../../core/utlis/app_assets.dart';
import '../../tabs/home_screen/home_screen.dart';
import '../../tabs/profile_screen/profile_screen.dart';
import 'wrapper_screen_states.dart'
    show WrapperScreenInitial, WrapperScreenStates, WrapperScreenIndexChanged;

@injectable
class WrapperScreenViewModel extends Cubit<WrapperScreenStates> {
  WrapperScreenViewModel() : super(WrapperScreenInitial());

  int selectedIndex = 0; // just a normal public variable, no get needed

  final navIcons = [AppAssets.home, AppAssets.orders, AppAssets.profile];

  final List<Widget> selectedWidget = [
    const HomeScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex = index; // just update it directly
    emit(WrapperScreenIndexChanged(index)); // this makes the UI rebuild
  }
}
