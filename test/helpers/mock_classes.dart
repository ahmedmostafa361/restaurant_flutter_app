import 'package:mocktail/mocktail.dart';
import 'package:restaurant_flutter_app/core/cache_save_data/auth_local_storage.dart';
import 'package:restaurant_flutter_app/data/data_sources/remote/orders_remote_data_source.dart';
import 'package:restaurant_flutter_app/data/data_sources/remote/restaurants_remote_data_source.dart';
import 'package:restaurant_flutter_app/domain/repository/auth/auth_repository.dart';
import 'package:restaurant_flutter_app/domain/repository/menu/menu_items_repository.dart';
import 'package:restaurant_flutter_app/domain/repository/menu/menu_repository.dart';
import 'package:restaurant_flutter_app/domain/repository/orders/orders_repository.dart';
import 'package:restaurant_flutter_app/domain/repository/restaurants/restaurants_repository.dart';
import 'package:restaurant_flutter_app/domain/use_cases/delete_order_use_case.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_all_restaurants_use_case.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_order_details_use_case.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_orders_history_use_case.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_restaurant_by_id_use_case.dart';
import 'package:restaurant_flutter_app/domain/use_cases/get_restaurant_menu_use_case.dart';
import 'package:restaurant_flutter_app/domain/use_cases/login_use_case.dart';
import 'package:restaurant_flutter_app/domain/use_cases/place_order_use_case.dart';
import 'package:restaurant_flutter_app/domain/use_cases/register_use_case.dart';
import 'package:restaurant_flutter_app/domain/use_cases/search_items_use_case.dart';

class MockRestaurantsRemoteDataSource extends Mock
    implements RestaurantsRemoteDataSource {}

class MockOrdersRemoteDataSource extends Mock
    implements OrdersRemoteDataSource {}

class MockRestaurantsRepository extends Mock implements RestaurantsRepository {}

class MockMenuRepository extends Mock implements MenuRepository {}

class MockItemsRepository extends Mock implements ItemsRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockOrdersRepository extends Mock implements OrdersRepository {}

class MockPlaceOrderUseCase extends Mock implements PlaceOrderUseCase {}

class MockGetOrdersUseCase extends Mock implements GetOrdersUseCase {}

class MockGetOrderDetailsUseCase extends Mock
    implements GetOrderDetailsUseCase {}

class MockDeleteOrderUseCase extends Mock implements DeleteOrderUseCase {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockAuthLocalStorage extends Mock implements AuthLocalStorage {}

class MockSearchItemsUseCase extends Mock implements SearchItemsUseCase {}

class MockGetAllRestaurantsUseCase extends Mock
    implements GetAllRestaurantsUseCase {}

class MockGetRestaurantByIdUseCase extends Mock
    implements GetRestaurantByIdUseCase {}

class MockGetRestaurantMenuUseCase extends Mock
    implements GetRestaurantMenuUseCase {}