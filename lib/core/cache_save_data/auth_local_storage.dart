import 'package:injectable/injectable.dart';
import 'package:restaurant_flutter_app/core/cache_save_data/secure_storage.dart';

@singleton
class AuthLocalStorage {
  Future<void> saveUserCode(String userCode) async {
    await SecureStorageUtils.saveUserCode(userCode);
  }

  Future<String?> getUserCode() async {
    return await SecureStorageUtils.getUserCode();
  }

  Future<void> clearUserCode() async {
    await SecureStorageUtils.clearUserCode();
  }
}