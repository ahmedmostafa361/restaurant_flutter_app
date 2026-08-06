import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_services.dart';
import '../end_points.dart';
import 'dio_exceptions/dio_interceptors.dart';

@module
abstract class GetItModule {

  @singleton
  BaseOptions provideBaseOptions() => BaseOptions(
    baseUrl: EndPoints.baseUrl,
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  );

  @singleton
  PrettyDioLogger providePrettyDioLogger() => PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    responseHeader: true,
    request: true,
    error: true,
  );

  @singleton
  Dio provideDio(
      BaseOptions baseOptions,
      PrettyDioLogger prettyDioLogger,
      ) {
    final dio = Dio(baseOptions);
    dio.interceptors.add(DioInterceptors());
    dio.interceptors.add(prettyDioLogger);
    return dio;
  }

  @singleton
  ApiServices provideApiServices(Dio dio) => ApiServices(dio);

  @preResolve
  Future<SharedPreferences> provideSharedPreferences() =>
      SharedPreferences.getInstance();
}