import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_all_restaurants_use_case.dart';

import '../../helpers/mock_classes.dart';

void main() {
  late MockRestaurantsRepository mockRepository;
  late GetAllRestaurantsUseCase useCase;

  setUp(() {
    mockRepository = MockRestaurantsRepository();
    useCase = GetAllRestaurantsUseCase(mockRepository);
  });

  test(
      'invoke calls repository.getRestaurants and returns its result', () async {
    final restaurants = [
      Restaurant(restaurantID: 4,
          restaurantName: 'Paradise Biryani',
          address: 'Hyderabad'),
    ];
    when(() => mockRepository.getRestaurants()).thenAnswer((
        _) async => restaurants);

    final result = await useCase.invoke();

    expect(result, restaurants);
    verify(() => mockRepository.getRestaurants()).called(1);
  });

  test('invoke propagates exceptions from the repository', () async {
    when(() => mockRepository.getRestaurants()).thenThrow(
        Exception('network error'));

    expect(() => useCase.invoke(), throwsException);
  });
}