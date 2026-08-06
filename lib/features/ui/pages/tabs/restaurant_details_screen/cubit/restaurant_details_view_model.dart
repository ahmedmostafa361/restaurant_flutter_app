import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_restaurant_by_id_use_case.dart';

import '../../../../../../api/dio/dio_exceptions/app_exceptions.dart';
import 'restaurant_details_states.dart';

@injectable
class RestaurantDetailsViewModel extends Cubit<RestaurantDetailsStates> {
  final GetRestaurantByIdUseCase getRestaurantByIdUseCase;

  RestaurantDetailsViewModel(this.getRestaurantByIdUseCase)
      : super(RestaurantDetailsInitialState());

  Future<void> getRestaurantById(int id) async {
    emit(RestaurantDetailsLoadingState());
    try {
      final restaurant = await getRestaurantByIdUseCase.invoke(id);
      emit(RestaurantDetailsSuccessState(restaurant: restaurant));
    } on ServerErrorException catch (e) {
      emit(RestaurantDetailsErrorState(errorMessage: e.errorMessage));
    } catch (e) {
      emit(RestaurantDetailsErrorState(
          errorMessage: "Something went wrong, please try again."));
    }
  }
}