import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/data_sources/remote/menu/menu_items_remote_data_source_impl.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/menu/menu_item.dart';

import '../../../helpers/mock_classes.dart';

void main() {
  late MockItemsRemoteDataSource mockRemoteDataSource;
  late ItemsRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockItemsRemoteDataSource();
    repository = ItemsRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  test(
    'searchItems delegates to the remote data source with itemName',
    () async {
      final items = [
        MenuItem(itemID: 1, itemName: 'Fish Curry', itemPrice: 220),
      ];
      when(
        () => mockRemoteDataSource.searchItems('fish'),
      ).thenAnswer((_) async => items);

      final result = await repository.searchItems('fish');

      expect(result, items);
      verify(() => mockRemoteDataSource.searchItems('fish')).called(1);
    },
  );
}
