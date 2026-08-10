import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/delete_order.dart';
import 'package:restaurant_flutter_app/domain/use_cases/delete_order_use_case.dart';

import '../../helpers/mock_classes.dart';

void main() {
  late MockOrdersRepository mockRepository;
  late DeleteOrderUseCase useCase;

  setUp(() {
    mockRepository = MockOrdersRepository();
    useCase = DeleteOrderUseCase(mockRepository);
  });

  test(
      'invoke calls repository.deleteSingleOrderById with orderId and apikey, returns its result', () async {
    final deleteResult = DeleteOrder(
        message: 'Order deleted', orderExists: null);
    when(() => mockRepository.deleteSingleOrderById(215, 'apikey123'))
        .thenAnswer((_) async => deleteResult);

    final result = await useCase.invoke(215, 'apikey123');

    expect(result, deleteResult);
    verify(() => mockRepository.deleteSingleOrderById(215, 'apikey123')).called(
        1);
  });
}