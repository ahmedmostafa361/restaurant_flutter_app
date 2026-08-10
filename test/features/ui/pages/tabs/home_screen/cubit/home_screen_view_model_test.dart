import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/cubit/home_screen_states.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/home_screen/cubit/home_screen_view_model.dart';

import '../../../../../../helpers/mock_classes.dart';

void main() {
  late MockGetAllRestaurantsUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetAllRestaurantsUseCase();
  });

  group('HomeScreenViewModel', () {
    final restaurants = [
      Restaurant(
        restaurantID: 4,
        restaurantName: 'Paradise Biryani',
        address: 'Hyderabad',
        type: 'Indian',
        parkingLot: true,
      ),
    ];

    blocTest<HomeScreenViewModel, HomeScreenStates>(
      'emits [Loading, Success] with restaurant list when getRestaurants succeeds',
      build: () {
        when(() => mockUseCase.invoke()).thenAnswer((_) async => restaurants);
        return HomeScreenViewModel(mockUseCase);
      },
      act: (cubit) => cubit.getRestaurants(),
      expect: () =>
      [
        isA<HomeScreenLoadingState>(),
        isA<HomeScreenSuccessState>()
            .having((s) => s.restaurants.length, 'restaurants.length', 1)
            .having((s) => s.restaurants.first.restaurantName, 'restaurantName',
            'Paradise Biryani'),
      ],
      verify: (_) {
        verify(() => mockUseCase.invoke()).called(1);
      },
    );

    blocTest<HomeScreenViewModel, HomeScreenStates>(
      'emits [Loading, Success] with an empty list when there are no restaurants',
      build: () {
        when(() => mockUseCase.invoke()).thenAnswer((_) async => []);
        return HomeScreenViewModel(mockUseCase);
      },
      act: (cubit) => cubit.getRestaurants(),
      expect: () =>
      [
        isA<HomeScreenLoadingState>(),
        isA<HomeScreenSuccessState>().having((s) => s.restaurants,
            'restaurants', isEmpty),
      ],
    );

    blocTest<HomeScreenViewModel, HomeScreenStates>(
      'emits [Loading, Error] when the use case throws ServerErrorException',
      build: () {
        when(() => mockUseCase.invoke())
            .thenThrow(ServerErrorException(errorMessage: 'Network error'));
        return HomeScreenViewModel(mockUseCase);
      },
      act: (cubit) => cubit.getRestaurants(),
      expect: () =>
      [
        isA<HomeScreenLoadingState>(),
        isA<HomeScreenErrorState>().having((s) => s.errorMessage,
            'errorMessage', 'Network error'),
      ],
    );

    blocTest<HomeScreenViewModel, HomeScreenStates>(
      'emits [Loading, Error] with fallback message for unexpected exceptions',
      build: () {
        when(() => mockUseCase.invoke()).thenThrow(Exception('unexpected'));
        return HomeScreenViewModel(mockUseCase);
      },
      act: (cubit) => cubit.getRestaurants(),
      expect: () =>
      [
        isA<HomeScreenLoadingState>(),
        isA<HomeScreenErrorState>()
            .having((s) => s.errorMessage, 'errorMessage',
            'Something went wrong, please try again.'),
      ],
    );
  });
}