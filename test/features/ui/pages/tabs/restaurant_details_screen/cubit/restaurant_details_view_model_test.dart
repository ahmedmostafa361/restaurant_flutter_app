import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/menu/menu_response.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/restaurant_details_screen/cubit/restaurant_details_states.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/restaurant_details_screen/cubit/restaurant_details_view_model.dart';

import '../../../../../../helpers/mock_classes.dart';

void main() {
  late MockGetRestaurantByIdUseCase mockGetRestaurantByIdUseCase;
  late MockGetRestaurantMenuUseCase mockGetRestaurantMenuUseCase;

  final restaurant = Restaurant(
    restaurantID: 5,
    restaurantName: 'Paradise Biryani',
    address: 'Hyderabad',
    type: 'Indian',
    parkingLot: true,
  );

  final menu = [
    MenuResponse(
      itemID: 1,
      itemName: 'Chicken Biryani',
      itemDescription: 'Spicy rice dish',
      itemPrice: 280,
      restaurantName: 'Paradise Biryani',
      restaurantID: 5,
      imageUrl: null,
    ),
  ];

  setUp(() {
    mockGetRestaurantByIdUseCase = MockGetRestaurantByIdUseCase();
    mockGetRestaurantMenuUseCase = MockGetRestaurantMenuUseCase();
  });

  group('RestaurantDetailsViewModel — getRestaurantDetails', () {
    blocTest<RestaurantDetailsViewModel, RestaurantDetailsStates>(
      'emits [Loading, Success] with restaurant and menu when both calls succeed',
      build: () {
        when(() => mockGetRestaurantByIdUseCase.invoke(5)).thenAnswer((
            _) async => restaurant);
        when(() => mockGetRestaurantMenuUseCase.invoke(5, sortByPrice: null))
            .thenAnswer((_) async => menu);
        return RestaurantDetailsViewModel(
            mockGetRestaurantByIdUseCase, mockGetRestaurantMenuUseCase);
      },
      act: (cubit) => cubit.getRestaurantDetails(5),
      expect: () =>
      [
        isA<RestaurantDetailsLoadingState>(),
        isA<RestaurantDetailsSuccessState>()
            .having((s) => s.restaurant.restaurantName, 'restaurantName',
            'Paradise Biryani')
            .having((s) => s.menu.length, 'menu.length', 1),
      ],
      verify: (_) {
        verify(() => mockGetRestaurantByIdUseCase.invoke(5)).called(1);
        verify(() => mockGetRestaurantMenuUseCase.invoke(5, sortByPrice: null))
            .called(1);
      },
    );

    blocTest<RestaurantDetailsViewModel, RestaurantDetailsStates>(
      'passes sortByPrice through to the menu use case',
      build: () {
        when(() => mockGetRestaurantByIdUseCase.invoke(5)).thenAnswer((
            _) async => restaurant);
        when(() => mockGetRestaurantMenuUseCase.invoke(5, sortByPrice: 'asc'))
            .thenAnswer((_) async => menu);
        return RestaurantDetailsViewModel(
            mockGetRestaurantByIdUseCase, mockGetRestaurantMenuUseCase);
      },
      act: (cubit) => cubit.getRestaurantDetails(5, sortByPrice: 'asc'),
      expect: () =>
      [
        isA<RestaurantDetailsLoadingState>(),
        isA<RestaurantDetailsSuccessState>(),
      ],
      verify: (_) {
        verify(() => mockGetRestaurantMenuUseCase.invoke(5, sortByPrice: 'asc'))
            .called(1);
      },
    );

    blocTest<RestaurantDetailsViewModel, RestaurantDetailsStates>(
      'emits [Loading, Error] when getRestaurantByIdUseCase throws',
      build: () {
        when(() => mockGetRestaurantByIdUseCase.invoke(5))
            .thenThrow(
            ServerErrorException(errorMessage: 'Restaurant not found'));
        when(() => mockGetRestaurantMenuUseCase.invoke(5, sortByPrice: null))
            .thenAnswer((_) async => menu);
        return RestaurantDetailsViewModel(
            mockGetRestaurantByIdUseCase, mockGetRestaurantMenuUseCase);
      },
      act: (cubit) => cubit.getRestaurantDetails(5),
      expect: () =>
      [
        isA<RestaurantDetailsLoadingState>(),
        isA<RestaurantDetailsErrorState>()
            .having((s) => s.errorMessage, 'errorMessage',
            'Restaurant not found'),
      ],
    );

    blocTest<RestaurantDetailsViewModel, RestaurantDetailsStates>(
      'emits [Loading, Error] when getRestaurantMenuUseCase throws',
      build: () {
        when(() => mockGetRestaurantByIdUseCase.invoke(5)).thenAnswer((
            _) async => restaurant);
        when(() => mockGetRestaurantMenuUseCase.invoke(5, sortByPrice: null))
            .thenThrow(ServerErrorException(errorMessage: 'Menu unavailable'));
        return RestaurantDetailsViewModel(
            mockGetRestaurantByIdUseCase, mockGetRestaurantMenuUseCase);
      },
      act: (cubit) => cubit.getRestaurantDetails(5),
      expect: () =>
      [
        isA<RestaurantDetailsLoadingState>(),
        isA<RestaurantDetailsErrorState>()
            .having((s) => s.errorMessage, 'errorMessage', 'Menu unavailable'),
      ],
    );
  });

  group('RestaurantDetailsViewModel — resortMenu', () {
    blocTest<RestaurantDetailsViewModel, RestaurantDetailsStates>(
      'emits MenuSortingState with the same restaurant and re-sorted menu, without re-fetching restaurant details',
      build: () {
        when(() => mockGetRestaurantByIdUseCase.invoke(5)).thenAnswer((
            _) async => restaurant);
        when(() => mockGetRestaurantMenuUseCase.invoke(5, sortByPrice: null))
            .thenAnswer((_) async => menu);
        when(() => mockGetRestaurantMenuUseCase.invoke(5, sortByPrice: 'desc'))
            .thenAnswer((_) async => menu.reversed.toList());
        return RestaurantDetailsViewModel(
            mockGetRestaurantByIdUseCase, mockGetRestaurantMenuUseCase);
      },
      act: (cubit) async {
        await cubit.getRestaurantDetails(5); // establish initial success state
        await cubit.resortMenu(5, 'desc');
      },
      skip: 2,
      // skip Loading + Success from getRestaurantDetails
      expect: () =>
      [
        isA<MenuSortingState>().having((s) => s.restaurant.restaurantID,
            'restaurantID', 5),
      ],
      verify: (_) {
        // restaurant details fetched only once — resortMenu should not call this again
        verify(() => mockGetRestaurantByIdUseCase.invoke(5)).called(1);
        verify(() =>
            mockGetRestaurantMenuUseCase.invoke(5, sortByPrice: 'desc')).called(
            1);
      },
    );

    blocTest<RestaurantDetailsViewModel, RestaurantDetailsStates>(
      'resortMenu does nothing if called before any successful fetch',
      build: () =>
          RestaurantDetailsViewModel(
              mockGetRestaurantByIdUseCase, mockGetRestaurantMenuUseCase),
      act: (cubit) => cubit.resortMenu(5, 'asc'),
      expect: () => [], // guarded early-return, no state change
    );

    blocTest<RestaurantDetailsViewModel, RestaurantDetailsStates>(
      'resortMenu emits Error if the menu use case throws',
      build: () {
        when(() => mockGetRestaurantByIdUseCase.invoke(5)).thenAnswer((
            _) async => restaurant);
        when(() => mockGetRestaurantMenuUseCase.invoke(5, sortByPrice: null))
            .thenAnswer((_) async => menu);
        when(() => mockGetRestaurantMenuUseCase.invoke(5, sortByPrice: 'desc'))
            .thenThrow(ServerErrorException(errorMessage: 'Sort failed'));
        return RestaurantDetailsViewModel(
            mockGetRestaurantByIdUseCase, mockGetRestaurantMenuUseCase);
      },
      act: (cubit) async {
        await cubit.getRestaurantDetails(5);
        await cubit.resortMenu(5, 'desc');
      },
      skip: 2,
      expect: () =>
      [
        isA<RestaurantDetailsErrorState>().having((s) => s.errorMessage,
            'errorMessage', 'Sort failed'),
      ],
    );
  });
}