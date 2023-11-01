import 'package:courier_app/src/domain/services/secure_storage/secure_storage_service.dart';
import 'package:courier_app/src/presentation/ui/auth/auth_screen.dart';
import 'package:courier_app/src/presentation/ui/main/main_screen.dart';
import 'package:get/get.dart';

abstract class InitService{
  static Future<void> initialize() async {
    await Future.delayed(Duration(seconds: 2));
    final _token = await SecureStorage.getToken();
    final _haveAccess = _token?.isNotEmpty==true;
    if(_haveAccess) {
      Get.to(MainScreen());
    }else{
      SecureStorage.clearData();
      Get.to(AuthScreen());
    }
  }
}