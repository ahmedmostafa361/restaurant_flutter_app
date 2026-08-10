import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/restaurants/restaurant.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_restaurant_by_id_use_case.dart';

import '../../helpers/mock_classes.dart';

void main() {
  late MockRestaurantsRepository mockRepository;
  late GetRestaurantByIdUseCase useCase;

  setUp(() {
    mockRepository = MockRestaurantsRepository();
    useCase = GetRestaurantByIdUseCase(mockRepository);
  });

  test(
      'invoke calls repository.getRestaurantById with the correct id', () async {
    final restaurant = Restaurant(
        restaurantID: 5, restaurantName: 'Paradise Biryani');
    when(() => mockRepository.getRestaurantById(5)).thenAnswer((
        _) async => restaurant);

    final result = await useCase.invoke(5);

    expect(result, restaurant);
    verify(() => mockRepository.getRestaurantById(5)).called(1);
  });
}