import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/api/data_sources/remote/menu/menu_remote_data_source_impl.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/menu/menu_response.dart';

import '../../../helpers/mock_classes.dart';

void main() {
  late MockMenuRemoteDataSource mockRemoteDataSource;
  late MenuRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockMenuRemoteDataSource();
    repository = MenuRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  test(
    'getMenu delegates to the remote data source with id and sortByPrice',
    () async {
      final menu = [
        MenuResponse(itemID: 1, itemName: 'Chicken Biryani', itemPrice: 280),
      ];
      when(
        () => mockRemoteDataSource.getMenu(5, 'asc'),
      ).thenAnswer((_) async => menu);

      final result = await repository.getMenu(5, 'asc');

      expect(result, menu);
      verify(() => mockRemoteDataSource.getMenu(5, 'asc')).called(1);
    },
  );
}
