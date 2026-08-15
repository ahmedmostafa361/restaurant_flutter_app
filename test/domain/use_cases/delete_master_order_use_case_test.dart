import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/delete_master_order.dart';
import 'package:restaurant_flutter_app/domain/use_cases/delete_master_order_use_case.dart';

import '../../helpers/mock_classes.dart';

void main() {
  late MockOrdersRepository mockRepository;
  late DeleteMasterOrderUseCase useCase;

  setUp(() {
    mockRepository = MockOrdersRepository();
    useCase = DeleteMasterOrderUseCase(mockRepository);
  });

  test(
    'invoke calls repository.deleteMasterOrder with masterId and apikey, returns its result',
    () async {
      final result = DeleteMasterOrder(
        message: 'Master order deleted',
        orderExists: [],
        singleOrders: [],
      );
      when(
        () => mockRepository.deleteMasterOrder(150, 'apikey123'),
      ).thenAnswer((_) async => result);

      final actual = await useCase.invoke(150, 'apikey123');

      expect(actual, result);
      verify(
        () => mockRepository.deleteMasterOrder(150, 'apikey123'),
      ).called(1);
    },
  );
}
