import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/domain/entinties/request/make_order_request.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/master_order.dart';
import 'package:restaurant_flutter_app/domain/use_cases/place_order_use_case.dart';

import '../../helpers/mock_classes.dart';

void main() {
  late MockOrdersRepository mockRepository;
  late PlaceOrderUseCase useCase;

  setUp(() {
    mockRepository = MockOrdersRepository();
    useCase = PlaceOrderUseCase(mockRepository);
  });

  test(
      'invoke calls repository.makeOrder with request and apikey, returns its result', () async {
    final request = MakeOrderRequest(restaurantId: 4, items: []);
    final response = MakeOrderResponse(fullOrder: [], grandTotal: 560.0);
    when(() => mockRepository.makeOrder(request, 'apikey123')).thenAnswer((
        _) async => response);

    final result = await useCase.invoke(request, 'apikey123');

    expect(result, response);
    verify(() => mockRepository.makeOrder(request, 'apikey123')).called(1);
  });
}