import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/api/api_services.dart';
import 'package:restaurant_flutter_app/api/mappers/menu/menu_item_mappers.dart';
import 'package:restaurant_flutter_app/data/data_sources/remote/items_remote_data_source.dart';

import '../../../api/dio/dio_exceptions/app_exceptions.dart';
import '../../../domain/entinties/response/menu/menu_item.dart';

@Injectable(as: ItemsRemoteDataSource)
class ItemsRemoteDataSourceImpl implements ItemsRemoteDataSource {
  final ApiServices apiServices;

  ItemsRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<List<MenuItem>> searchItems(String? itemName) async {
    try {
      var itemsResponse = await apiServices.getRestaurantItems(itemName);
      return itemsResponse.map((dto) => dto.toDomain()).toList();
    } on DioException catch (e) {
      String message = (e.error as AppException).errorMessage;
      throw ServerErrorException(errorMessage: message);
    }
  }
}
