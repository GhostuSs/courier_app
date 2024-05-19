import 'package:courier_app/src/di/di.dart';
import 'package:courier_app/src/domain/services/api/api_service.dart';
import 'package:courier_app/src/domain/services/geo/geo_service.dart';
import 'package:courier_app/src/domain/services/secure_storage/secure_storage_service.dart';
import 'package:courier_app/src/presentation/ui/auth/auth_screen.dart';
import 'package:courier_app/src/presentation/ui/auth/uikit/error_screen.dart';
import 'package:courier_app/src/presentation/ui/main/main_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class InitService {
  static Future<void> initialize() async {
    InternetConnection internetConnectionChecker =
        InternetConnection.createInstance();
    if (await internetConnectionChecker.hasInternetAccess) {
      final _token = await SecureStorage.getToken();
      final _haveAccess = _token.isNotEmpty == true;
      if (_haveAccess) {
        Get.to(const MainScreen());
        GeoService.determinePosition();
      } else {
        SecureStorage.clearData();
        Get.to(const AuthScreen());
      }
      try{
        final value = await FirebaseMessaging.instance.getToken();
        if(value!=null)getIt<ApiService>().saveToken(token: value);
      }on Exception catch (e){
        print(e);
      }
    } else {
      Get.to(const ErrorScreen(type: ErrorType.noInternet));
    }
  }
}
