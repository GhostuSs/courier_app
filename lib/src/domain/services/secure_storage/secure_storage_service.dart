import 'package:courier_app/src/domain/models/auth/auth_response_model/auth_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  static const String _tokenKey = 'token';
  static String? preloadedToken;

  static FlutterSecureStorage get storage => const FlutterSecureStorage();

  static Future<String?> getToken() async =>
      await storage.read(key: _tokenKey).then(
          (value) => preloadedToken = kDebugMode ? dotenv.env['TOKEN'] : value);

  static Future<void> clearData() async =>
      await storage.deleteAll().then((value) => preloadedToken = null);

  static Future<void> putToken(
          {required AuthResponseModel responseModel}) async =>
      await storage.write(key: _tokenKey, value: responseModel.token);
}
