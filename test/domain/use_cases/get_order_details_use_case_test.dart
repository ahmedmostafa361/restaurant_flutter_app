import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/orders/order_details.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_order_details_use_case.dart';

import '../../helpers/mock_classes.dart';

void main() {
  late MockOrdersRepository mockRepository;
  late GetOrderDetailsUseCase useCase;

  setUp(() {
    mockRepository = MockOrdersRepository();
    useCase = GetOrderDetailsUseCase(mockRepository);
  });

  test(
      'invoke calls repository.getOrderDetailsById with masterId and apikey, returns its result', () async {
    final lineItems = [
      OrderDetails(orderID: 215,
          itemName: 'Chicken Biryani',
          quantity: 2,
          itemPrice: 280.0,
          masterID: 150),
    ];
    when(() => mockRepository.getOrderDetailsById(150, 'apikey123'))
        .thenAnswer((_) async => lineItems);

    final result = await useCase.invoke(150, 'apikey123');

    expect(result, lineItems);
    verify(() => mockRepository.getOrderDetailsById(150, 'apikey123')).called(
        1);
  });
}