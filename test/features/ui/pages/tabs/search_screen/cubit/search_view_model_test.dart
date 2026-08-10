import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/dio/dio_exceptions/app_exceptions.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/menu/menu_item.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/search_screen/cubit/search_states.dart';
import 'package:restaurant_flutter_app/features/ui/pages/tabs/search_screen/cubit/search_view_model.dart';

import '../../../../../../helpers/mock_classes.dart';

void main() {
  late MockSearchItemsUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockSearchItemsUseCase();
  });

  final items = [
    MenuItem(
      itemID: 1,
      itemName: 'Fish Curry',
      itemDescription: 'Spicy fish dish',
      itemPrice: 220,
      restaurantName: 'Paradise Biryani',
      restaurantID: 5,
      imageUrl: null,
    ),
  ];

  group('SearchViewModel', () {
    blocTest<SearchViewModel, SearchStates>(
      'emits SearchInitialState immediately when query is empty, without calling the use case',
      build: () => SearchViewModel(mockUseCase),
      act: (cubit) => cubit.onSearchQueryChanged(''),
      expect: () => [isA<SearchInitialState>()],
      verify: (_) {
        verifyNever(() => mockUseCase.invoke(itemName: any(named: 'itemName')));
      },
    );

    blocTest<SearchViewModel, SearchStates>(
      'emits SearchInitialState immediately when query is only whitespace',
      build: () => SearchViewModel(mockUseCase),
      act: (cubit) => cubit.onSearchQueryChanged('   '),
      expect: () => [isA<SearchInitialState>()],
      verify: (_) {
        verifyNever(() => mockUseCase.invoke(itemName: any(named: 'itemName')));
      },
    );

    blocTest<SearchViewModel, SearchStates>(
      'emits [Loading, Success] after debounce delay when query has results',
      build: () {
        when(() => mockUseCase.invoke(itemName: 'fish')).thenAnswer((
            _) async => items);
        return SearchViewModel(mockUseCase);
      },
      act: (cubit) => cubit.onSearchQueryChanged('fish'),
      wait: const Duration(milliseconds: 600),
      // longer than the 450ms debounce
      expect: () =>
      [
        isA<SearchLoadingState>(),
        isA<SearchSuccessState>()
            .having((s) => s.items.length, 'items.length', 1)
            .having((s) => s.items.first.itemName, 'itemName', 'Fish Curry'),
      ],
      verify: (_) {
        verify(() => mockUseCase.invoke(itemName: 'fish')).called(1);
      },
    );

    blocTest<SearchViewModel, SearchStates>(
      'emits [Loading, Empty] when the search returns no results',
      build: () {
        when(() => mockUseCase.invoke(itemName: 'nonexistent')).thenAnswer((
            _) async => []);
        return SearchViewModel(mockUseCase);
      },
      act: (cubit) => cubit.onSearchQueryChanged('nonexistent'),
      wait: const Duration(milliseconds: 600),
      expect: () =>
      [
        isA<SearchLoadingState>(),
        isA<SearchEmptyState>(),
      ],
    );

    blocTest<SearchViewModel, SearchStates>(
      'emits [Loading, Error] when the use case throws',
      build: () {
        when(() => mockUseCase.invoke(itemName: 'fish'))
            .thenThrow(ServerErrorException(errorMessage: 'Search failed'));
        return SearchViewModel(mockUseCase);
      },
      act: (cubit) => cubit.onSearchQueryChanged('fish'),
      wait: const Duration(milliseconds: 600),
      expect: () =>
      [
        isA<SearchLoadingState>(),
        isA<SearchErrorState>().having((s) => s.errorMessage, 'errorMessage',
            'Search failed'),
      ],
    );

    blocTest<SearchViewModel, SearchStates>(
      'rapid successive keystrokes cancel prior debounce timers — only the last query is searched',
      build: () {
        when(() => mockUseCase.invoke(itemName: 'fish')).thenAnswer((
            _) async => items);
        return SearchViewModel(mockUseCase);
      },
      act: (cubit) async {
        cubit.onSearchQueryChanged('f');
        await Future.delayed(
            const Duration(milliseconds: 100)); // well under 450ms
        cubit.onSearchQueryChanged('fi');
        await Future.delayed(const Duration(milliseconds: 100));
        cubit.onSearchQueryChanged('fis');
        await Future.delayed(const Duration(milliseconds: 100));
        cubit.onSearchQueryChanged(
            'fish'); // only this one should survive the debounce
      },
      wait: const Duration(milliseconds: 600),
      // let the final debounce fire
      expect: () =>
      [
        isA<SearchLoadingState>(),
        isA<SearchSuccessState>(),
      ],
      verify: (_) {
        // the use case should only ever be called once, with the final query
        verify(() => mockUseCase.invoke(itemName: 'fish')).called(1);
        verifyNever(() => mockUseCase.invoke(itemName: 'f'));
        verifyNever(() => mockUseCase.invoke(itemName: 'fi'));
        verifyNever(() => mockUseCase.invoke(itemName: 'fis'));
      },
    );

    blocTest<SearchViewModel, SearchStates>(
      'clearing the query after a debounced search resets to SearchInitialState',
      build: () {
        when(() => mockUseCase.invoke(itemName: 'fish')).thenAnswer((
            _) async => items);
        return SearchViewModel(mockUseCase);
      },
      act: (cubit) async {
        cubit.onSearchQueryChanged('fish');
        await Future.delayed(
            const Duration(milliseconds: 600)); // let the search complete
        cubit.onSearchQueryChanged(''); // then clear
      },
      skip: 2, // skip Loading + Success from the initial search
      expect: () => [isA<SearchInitialState>()],
    );
  });
}