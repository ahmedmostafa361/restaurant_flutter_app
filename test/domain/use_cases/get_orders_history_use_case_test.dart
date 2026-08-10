import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/order_history_details.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_orders_history_use_case.dart';

import '../../helpers/mock_classes.dart';

void main() {
  late MockOrdersRepository mockRepository;
  late GetOrdersUseCase useCase;

  setUp(() {
    mockRepository = MockOrdersRepository();
    useCase = GetOrdersUseCase(mockRepository);
  });

  test(
      'invoke calls repository.getAllOrders with apikey, returns its result', () async {
    final orders = [
      OrderDetailsHistory(masterID: 150,
          userID: 'ahmed@bachelor.com',
          restaurantID: 4,
          grandTotal: 560.0),
    ];
    when(() => mockRepository.getAllOrders('apikey123')).thenAnswer((
        _) async => orders);

    final result = await useCase.invoke('apikey123');

    expect(result, orders);
    verify(() => mockRepository.getAllOrders('apikey123')).called(1);
  });
}