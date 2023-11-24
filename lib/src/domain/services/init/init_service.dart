import 'package:courier_app/src/domain/services/geo/geo_service.dart';
import 'package:courier_app/src/domain/services/secure_storage/secure_storage_service.dart';
import 'package:courier_app/src/presentation/ui/auth/auth_screen.dart';
import 'package:courier_app/src/presentation/ui/auth/uikit/error_screen.dart';
import 'package:courier_app/src/presentation/ui/main/main_screen.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class InitService {
  static Future<void> initialize() async {
    InternetConnection internetConnectionChecker =
        InternetConnection.createInstance();
    if (await internetConnectionChecker.hasInternetAccess) {
      final _token = await SecureStorage.getToken();
      final _haveAccess = _token?.isNotEmpty == true;
      if (_haveAccess) {
        Get.to(const MainScreen());
        GeoService.determinePosition();
      } else {
        SecureStorage.clearData();
        Get.to(const AuthScreen());
      }
    } else {
      Get.to(const ErrorScreen(type: ErrorType.noInternet));
    }
  }
}
