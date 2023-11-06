import 'package:courier_app/src/domain/models/auth/auth_response_model/auth_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  static const String _tokenKey = 'token';

  static FlutterSecureStorage get storage => const FlutterSecureStorage();

  static Future<String?> getToken() async => await storage.read(key: _tokenKey);

  static Future<void> clearData() async => await storage.deleteAll();

  static Future<void> putToken(
          {required AuthResponseModel responseModel}) async =>
      await storage.write(key: _tokenKey, value: responseModel.token);
}
