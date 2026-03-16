import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// LEARNING NOTES:
/// Responsible for: API calls and local storage.
/// NOT allowed to: contain business logic or UI.
/// 
/// PURPOSE: Handles local caching of auth-related data securely.
abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getCachedToken();
  Future<void> clearToken();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl(this.secureStorage);

  static const _tokenKey = 'auth_token';

  /// How flutter_secure_storage works internally:
  /// - On iOS, it uses the Keychain, which provides hardware-backed encryption.
  /// - On Android, it uses the Android Keystore to encrypt the data before saving it to SharedPreferences.
  /// 
  /// Why it is safer than shared_preferences for auth tokens:
  /// SharedPreferences stores data in plain text XML files on the device.
  /// Secure storage encrypts the data using keys managed by the OS keystore.
  /// 
  /// Why minSdkVersion 18 is required on Android:
  /// The Android Keystore API needed for encryption was introduced in API level 18 (Android 4.3).
  @override
  Future<void> cacheToken(String token) async {
    await secureStorage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getCachedToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  @override
  Future<void> clearToken() async {
    await secureStorage.delete(key: _tokenKey);
  }
}
