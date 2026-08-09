// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../api/api_services.dart' as _i124;
import '../api/data_sources/remote/auth/auth_remote_data_source_impl.dart'
    as _i983;
import '../api/data_sources/remote/menu/menu_items_remote_data_source_impl.dart'
    as _i984;
import '../api/data_sources/remote/menu/menu_remote_data_source_impl.dart'
    as _i309;
import '../api/data_sources/remote/orders/orders_remote_data_source_impl.dart'
    as _i66;
import '../api/data_sources/remote/restaurants/restaurants_remote_data_source_impl.dart'
    as _i459;
import '../api/dio/dio_module.dart' as _i223;
import '../core/cache_save_data/auth_local_storage.dart' as _i1047;
import '../data/data_sources/remote/auth_remote_data_source.dart' as _i354;
import '../data/data_sources/remote/items_remote_data_source.dart' as _i1062;
import '../data/data_sources/remote/menu_remote_data_source.dart' as _i880;
import '../data/data_sources/remote/orders_remote_data_source.dart' as _i646;
import '../data/data_sources/remote/restaurants_remote_data_source.dart'
    as _i16;
import '../data/repository/auth/auth_repository_impl.dart' as _i779;
import '../data/repository/menu/menu_items_repository_impl.dart' as _i590;
import '../data/repository/menu/menu_repository_impl.dart' as _i795;
import '../data/repository/orders/orders_repository_impl.dart' as _i402;
import '../data/repository/restaurants/restaurants_repository_impl.dart'
    as _i653;
import '../domain/repository/auth/auth_repository.dart' as _i824;
import '../domain/repository/menu/menu_items_repository.dart' as _i498;
import '../domain/repository/menu/menu_repository.dart' as _i582;
import '../domain/repository/orders/orders_repository.dart' as _i707;
import '../domain/repository/restaurants/restaurants_repository.dart' as _i601;
import '../domain/use_cases/delete_order_use_case.dart' as _i997;
import '../domain/use_cases/get_all_restaurants_use_case.dart' as _i731;
import '../domain/use_cases/get_order_details_use_case.dart' as _i501;
import '../domain/use_cases/get_orders_history_use_case.dart' as _i997;
import '../domain/use_cases/get_restaurant_by_id_use_case.dart' as _i592;
import '../domain/use_cases/get_restaurant_menu_use_case.dart' as _i563;
import '../domain/use_cases/login_use_case.dart' as _i826;
import '../domain/use_cases/place_order_use_case.dart' as _i60;
import '../domain/use_cases/register_use_case.dart' as _i772;
import '../domain/use_cases/search_items_use_case.dart' as _i35;
import '../features/ui/login_screen/cubit/login_view_model.dart' as _i1068;
import '../features/ui/pages/cart_screen/cubit/cart_view_model.dart' as _i65;
import '../features/ui/pages/orders_screen/cubit/order_details_screen_view_model.dart'
    as _i708;
import '../features/ui/pages/orders_screen/cubit/orders_history_view_model.dart'
    as _i960;
import '../features/ui/pages/orders_screen/cubit/orders_view_model.dart'
    as _i612;
import '../features/ui/pages/tabs/home_screen/cubit/home_screen_view_model.dart'
    as _i5;
import '../features/ui/pages/tabs/restaurant_details_screen/cubit/restaurant_details_view_model.dart'
    as _i851;
import '../features/ui/pages/tabs/search_screen/cubit/search_view_model.dart'
    as _i846;
import '../features/ui/register_screen/cubit/register_view_model.dart' as _i507;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final getItModule = _$GetItModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => getItModule.provideSharedPreferences(),
      preResolve: true,
    );
    gh.singleton<_i361.BaseOptions>(() => getItModule.provideBaseOptions());
    gh.singleton<_i528.PrettyDioLogger>(
      () => getItModule.providePrettyDioLogger(),
    );
    gh.singleton<_i1047.AuthLocalStorage>(() => _i1047.AuthLocalStorage());
    gh.lazySingleton<_i65.CartViewModel>(() => _i65.CartViewModel());
    gh.singleton<_i361.Dio>(
      () => getItModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i528.PrettyDioLogger>(),
      ),
    );
    gh.singleton<_i124.ApiServices>(
      () => getItModule.provideApiServices(gh<_i361.Dio>()),
    );
    gh.factory<_i880.MenuRemoteDataSource>(
      () =>
          _i795.MenuRemoteDataSourceImpl(apiServices: gh<_i124.ApiServices>()),
    );
    gh.factory<_i646.OrdersRemoteDataSource>(
      () => _i402.OrdersRemoteDataSourceImpl(
        apiServices: gh<_i124.ApiServices>(),
      ),
    );
    gh.factory<_i354.AuthRemoteDataSource>(
      () =>
          _i983.AuthRemoteDataSourceImpl(apiServices: gh<_i124.ApiServices>()),
    );
    gh.factory<_i16.RestaurantsRemoteDataSource>(
      () => _i459.RestaurantsRemoteDataSourceImpl(
        apiServices: gh<_i124.ApiServices>(),
      ),
    );
    gh.factory<_i1062.ItemsRemoteDataSource>(
      () =>
          _i590.ItemsRemoteDataSourceImpl(apiServices: gh<_i124.ApiServices>()),
    );
    gh.factory<_i498.ItemsRepository>(
      () => _i984.ItemsRepositoryImpl(
        remoteDataSource: gh<_i1062.ItemsRemoteDataSource>(),
      ),
    );
    gh.factory<_i824.AuthRepository>(
      () => _i779.AuthRepositoryImpl(
        remoteDataSource: gh<_i354.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i707.OrdersRepository>(
      () => _i66.OrdersRepositoryImpl(
        remoteDataSource: gh<_i646.OrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i582.MenuRepository>(
      () => _i309.MenuRepositoryImpl(
        remoteDataSource: gh<_i880.MenuRemoteDataSource>(),
      ),
    );
    gh.factory<_i563.GetRestaurantMenuUseCase>(
      () => _i563.GetRestaurantMenuUseCase(gh<_i582.MenuRepository>()),
    );
    gh.factory<_i826.LoginUseCase>(
      () => _i826.LoginUseCase(gh<_i824.AuthRepository>()),
    );
    gh.factory<_i772.RegisterUseCase>(
      () => _i772.RegisterUseCase(gh<_i824.AuthRepository>()),
    );
    gh.factory<_i35.SearchItemsUseCase>(
      () => _i35.SearchItemsUseCase(gh<_i498.ItemsRepository>()),
    );
    gh.factory<_i507.RegisterViewModel>(
      () => _i507.RegisterViewModel(gh<_i772.RegisterUseCase>()),
    );
    gh.factory<_i601.RestaurantsRepository>(
      () => _i653.RestaurantsRepositoryImpl(
        remoteDataSource: gh<_i16.RestaurantsRemoteDataSource>(),
      ),
    );
    gh.factory<_i846.SearchViewModel>(
      () => _i846.SearchViewModel(gh<_i35.SearchItemsUseCase>()),
    );
    gh.factory<_i997.DeleteOrderUseCase>(
      () => _i997.DeleteOrderUseCase(gh<_i707.OrdersRepository>()),
    );
    gh.factory<_i501.GetOrderDetailsUseCase>(
      () => _i501.GetOrderDetailsUseCase(gh<_i707.OrdersRepository>()),
    );
    gh.factory<_i997.GetOrdersUseCase>(
      () => _i997.GetOrdersUseCase(gh<_i707.OrdersRepository>()),
    );
    gh.factory<_i60.PlaceOrderUseCase>(
      () => _i60.PlaceOrderUseCase(gh<_i707.OrdersRepository>()),
    );
    gh.factory<_i960.OrdersHistoryViewModel>(
      () => _i960.OrdersHistoryViewModel(
        gh<_i997.GetOrdersUseCase>(),
        gh<_i1047.AuthLocalStorage>(),
      ),
    );
    gh.factory<_i1068.LoginViewModel>(
      () => _i1068.LoginViewModel(
        gh<_i826.LoginUseCase>(),
        gh<_i1047.AuthLocalStorage>(),
      ),
    );
    gh.factory<_i731.GetAllRestaurantsUseCase>(
      () => _i731.GetAllRestaurantsUseCase(gh<_i601.RestaurantsRepository>()),
    );
    gh.factory<_i592.GetRestaurantByIdUseCase>(
      () => _i592.GetRestaurantByIdUseCase(gh<_i601.RestaurantsRepository>()),
    );
    gh.factory<_i708.OrderDetailsScreenViewModel>(
      () => _i708.OrderDetailsScreenViewModel(
        gh<_i501.GetOrderDetailsUseCase>(),
        gh<_i1047.AuthLocalStorage>(),
        gh<_i997.DeleteOrderUseCase>(),
      ),
    );
    gh.factory<_i5.HomeScreenViewModel>(
      () => _i5.HomeScreenViewModel(gh<_i731.GetAllRestaurantsUseCase>()),
    );
    gh.factory<_i612.CheckoutViewModel>(
      () => _i612.CheckoutViewModel(
        gh<_i60.PlaceOrderUseCase>(),
        gh<_i1047.AuthLocalStorage>(),
      ),
    );
    gh.factory<_i851.RestaurantDetailsViewModel>(
      () => _i851.RestaurantDetailsViewModel(
        gh<_i592.GetRestaurantByIdUseCase>(),
        gh<_i563.GetRestaurantMenuUseCase>(),
      ),
    );
    return this;
  }
}

class _$GetItModule extends _i223.GetItModule {}
