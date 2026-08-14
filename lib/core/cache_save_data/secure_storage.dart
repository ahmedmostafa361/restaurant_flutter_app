// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// //
// // class SecureStorageUtils {
// //   SecureStorageUtils._();
// //
// //   // Encrypted secure storage configuration for Android and iOS
// //   static const FlutterSecureStorage _storage = FlutterSecureStorage(
// //     aOptions: AndroidOptions(
// //       encryptedSharedPreferences: true,
// //     ),
// //     iOptions: IOSOptions(
// //       accessibility: KeychainAccessibility.first_unlock,
// //     ),
// //   );
// //
// //   static const String _userCodeKey = 'USER_CODE';
// //
// //   /// Save sensitive user code asynchronously
// //   static Future<void> saveUserCode(String userCode) async {
// //     await _storage.write(key: _userCodeKey, value: userCode);
// //   }
// //
// //   /// Read user code asynchronously
// //   static Future<String?> getUserCode() async {
// //     return await _storage.read(key: _userCodeKey);
// //   }
// //
// //   /// Remove user code on logout
// //   static Future<void> clearUserCode() async {
// //     await _storage.delete(key: _userCodeKey);
// //   }
// //
// //   /// Wipe all secure data (e.g., on full account logout)
// //   static Future<void> clearAll() async {
// //     await _storage.deleteAll();
// //   }
// // }
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class SecureStorageUtils {
//   SecureStorageUtils._();
//
//   // Encrypted secure storage configuration for Android and iOS
//   static const FlutterSecureStorage _storage = FlutterSecureStorage(
//     aOptions: AndroidOptions(
//       encryptedSharedPreferences: true,
//     ),
//     iOptions: IOSOptions(
//       accessibility: KeychainAccessibility.first_unlock,
//     ),
//   );
//
//   static const String _userCodeKey = 'USER_CODE';
//   static const String _userEmailKey = 'USER_EMAIL';
//
//   /// Save sensitive user code asynchronously
//   static Future<void> saveUserCode(String userCode) async {
//     await _storage.write(key: _userCodeKey, value: userCode);
//   }
//
//   /// Read user code asynchronously
//   static Future<String?> getUserCode() async {
//     return await _storage.read(key: _userCodeKey);
//   }
//
//   /// Remove user code on logout
//   static Future<void> clearUserCode() async {
//     await _storage.delete(key: _userCodeKey);
//   }
//
//   /// Save the email captured at registration, so Profile can display it
//   static Future<void> saveUserEmail(String userEmail) async {
//     await _storage.write(key: _userEmailKey, value: userEmail);
//   }
//
//   /// Read the saved email asynchronously
//   static Future<String?> getUserEmail() async {
//     return await _storage.read(key: _userEmailKey);
//   }
//
//   /// Remove the saved email on logout
//   static Future<void> clearUserEmail() async {
//     await _storage.delete(key: _userEmailKey);
//   }
//
//   /// Wipe all secure data (e.g., on full account logout)
//   static Future<void> clearAll() async {
//     await _storage.deleteAll();
//   }
// }
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtils {
  SecureStorageUtils._();

  // Encrypted secure storage configuration for Android and iOS
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  static const String _userCodeKey = 'USER_CODE';
  static const String _userEmailKey = 'USER_EMAIL';

  /// Save sensitive user code asynchronously
  static Future<void> saveUserCode(String userCode) async {
    await _storage.write(key: _userCodeKey, value: userCode);
  }

  /// Read user code asynchronously
  static Future<String?> getUserCode() async {
    return await _storage.read(key: _userCodeKey);
  }

  /// Remove user code on logout
  static Future<void> clearUserCode() async {
    await _storage.delete(key: _userCodeKey);
  }

  /// Save the email captured at registration, so Profile can display it
  static Future<void> saveUserEmail(String userEmail) async {
    await _storage.write(key: _userEmailKey, value: userEmail);
  }

  /// Read the saved email asynchronously
  static Future<String?> getUserEmail() async {
    return await _storage.read(key: _userEmailKey);
  }

  /// Remove the saved email on logout
  static Future<void> clearUserEmail() async {
    await _storage.delete(key: _userEmailKey);
  }

  /// Wipe all secure data (e.g., on full account logout)
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}