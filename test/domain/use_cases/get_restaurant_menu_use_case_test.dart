import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/menu/menu_response.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_restaurant_menu_use_case.dart';

import '../../helpers/mock_classes.dart';

void main() {
  late MockMenuRepository mockRepository;
  late GetRestaurantMenuUseCase useCase;

  setUp(() {
    mockRepository = MockMenuRepository();
    useCase = GetRestaurantMenuUseCase(mockRepository);
  });

  test(
      'invoke calls repository.getMenu with id and null sort by default', () async {
    final menu = [
      MenuResponse(itemID: 1, itemName: 'Chicken Biryani', itemPrice: 280)
    ];
    when(() => mockRepository.getMenu(5, null)).thenAnswer((_) async => menu);

    final result = await useCase.invoke(5);

    expect(result, menu);
    verify(() => mockRepository.getMenu(5, null)).called(1);
  });

  test('invoke passes sortByPrice through to the repository', () async {
    final menu = [
      MenuResponse(itemID: 1, itemName: 'Chicken Biryani', itemPrice: 280)
    ];
    when(() => mockRepository.getMenu(5, 'asc')).thenAnswer((_) async => menu);

    await useCase.invoke(5, sortByPrice: 'asc');

    verify(() => mockRepository.getMenu(5, 'asc')).called(1);
  });
}