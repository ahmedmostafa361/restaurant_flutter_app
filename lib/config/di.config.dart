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
import '../api/data_sources/remote/restaurants/restaurants_remote_data_source_impl.dart'
    as _i459;
import '../api/dio/dio_module.dart' as _i223;
import '../data/data_sources/remote/restaurants_remote_data_source.dart'
    as _i16;
import '../data/repository/restaurants/restaurants_repository_impl.dart'
    as _i653;
import '../domain/repository/restaurants/restaurants_repository.dart' as _i601;
import '../domain/use_cases/get_all_restaurants_use_case.dart' as _i731;
import '../domain/use_cases/get_restaurant_by_id_use_case.dart' as _i592;
import '../features/ui/pages/tabs/home_screen/cubit/home_screen_view_model.dart'
    as _i5;
import '../features/ui/pages/tabs/restaurant_details_screen/cubit/restaurant_details_view_model.dart'
    as _i851;

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
    gh.factory<_i851.RestaurantDetailsViewModel>(
      () => _i851.RestaurantDetailsViewModel(
        gh<_i592.GetRestaurantByIdUseCase>(),
      ),
    );
    gh.singleton<_i361.Dio>(
      () => getItModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i528.PrettyDioLogger>(),
      ),
    );
    gh.factory<_i5.HomeScreenViewModel>(
      () => _i5.HomeScreenViewModel(gh<_i731.GetAllRestaurantsUseCase>()),
    );
    gh.singleton<_i124.ApiServices>(
      () => getItModule.provideApiServices(gh<_i361.Dio>()),
    );
    gh.factory<_i16.RestaurantsRemoteDataSource>(
      () => _i459.RestaurantsRemoteDataSourceImpl(
        apiServices: gh<_i124.ApiServices>(),
      ),
    );
    gh.factory<_i601.RestaurantsRepository>(
      () => _i653.RestaurantsRepositoryImpl(
        remoteDataSource: gh<_i16.RestaurantsRemoteDataSource>(),
      ),
    );
    return this;
  }
}

class _$GetItModule extends _i223.GetItModule {}
