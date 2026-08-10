import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/menu/menu_item.dart';
import 'package:restaurant_flutter_app/domain/use_cases/search_items_use_case.dart';

import '../../helpers/mock_classes.dart';

void main() {
  late MockItemsRepository mockRepository;
  late SearchItemsUseCase useCase;

  setUp(() {
    mockRepository = MockItemsRepository();
    useCase = SearchItemsUseCase(mockRepository);
  });

  test(
      'invoke calls repository.searchItems with the given item name', () async {
    final items = [MenuItem(itemID: 1, itemName: 'Fish Curry', itemPrice: 220)];
    when(() => mockRepository.searchItems('fish')).thenAnswer((
        _) async => items);

    final result = await useCase.invoke(itemName: 'fish');

    expect(result, items);
    verify(() => mockRepository.searchItems('fish')).called(1);
  });

  test('invoke passes null itemName through to the repository', () async {
    when(() => mockRepository.searchItems(null)).thenAnswer((_) async => []);

    await useCase.invoke();

    verify(() => mockRepository.searchItems(null)).called(1);
  });
}