import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_all_restaurants_use_case.dart';

import '../../../../../../api/dio/dio_exceptions/app_exceptions.dart';
import 'home_screen_states.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  final GetAllRestaurantsUseCase getAllRestaurantsUseCase;

  HomeScreenViewModel(this.getAllRestaurantsUseCase)
      : super(HomeScreenInitialState());

  Future<void> getRestaurants() async {
    emit(HomeScreenLoadingState());
    try {
      final restaurants = await getAllRestaurantsUseCase.invoke();
      emit(HomeScreenSuccessState(restaurants: restaurants));
    } on ServerErrorException catch (e) {
      emit(HomeScreenErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(HomeScreenErrorState(errorMessage: "Something went wrong, please try again."));
    }
  }
}