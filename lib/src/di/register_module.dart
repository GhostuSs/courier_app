import 'package:courier_app/src/domain/services/secure_storage/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio get httpClient => Dio(BaseOptions(
      headers: {'Authorization': 'Bearer ${SecureStorage.preloadedToken}'}));

  @singleton
  FlutterSecureStorage get storage => const FlutterSecureStorage();

}
