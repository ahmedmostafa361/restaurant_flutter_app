import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/api/api_services.dart';
import 'package:restaurant_flutter_app/api/mappers/menu/menu_response_mappers.dart';
import 'package:restaurant_flutter_app/data/data_sources/remote/menu_remote_data_source.dart';
import 'package:restaurant_flutter_app/domain/entinties/response/menu/menu_response.dart';

import '../../../api/dio/dio_exceptions/app_exceptions.dart';


@Injectable(as: MenuRemoteDataSource)
class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  final ApiServices apiServices;

  MenuRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<List<MenuResponse>> getMenu(int restaurantId,
      String? sortByPrice) async {
    try {
      var menuResponse = await apiServices.getMenu(restaurantId, sortByPrice);
      return menuResponse.map((dto) => dto.toDomain()).toList();
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }
}