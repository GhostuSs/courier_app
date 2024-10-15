import 'package:courier_app/src/di/di.dart';
import 'package:courier_app/src/domain/models/auth/auth_request_model/auth_request_model.dart';
import 'package:courier_app/src/domain/services/api/api_service.dart';
import 'package:courier_app/src/domain/services/secure_storage/secure_storage_service.dart';
import 'package:courier_app/src/presentation/ui/main/main_screen.dart';
import 'package:email_validator/email_validator.dart';

import 'package:courier_app/res/barrels/barrel.dart';

class AuthController extends GetxController {
  TextEditingController loginController = TextEditingController();
  TextEditingController passController = TextEditingController();

  RxBool entryEnabled = false.obs;
  RxBool obscurePass = true.obs;
  RxBool authorizing = false.obs;

  void onChange() {
    entryEnabled.value = EmailValidator.validate(loginController.text) && passController.text.length >= 6;
  }

  void changeObscuring() => obscurePass.value = !obscurePass.value;

  Future<void> authorize() async {
    if (loginController.text.isEmpty || passController.text.isEmpty) return;
    authorizing.value = true;
    final model = AuthRequestModel(
      email: loginController.text,
      password: passController.text,
    );
    try {
      final loginData = await getIt<ApiService>().login(model: model) ?? null;
      if (loginData != null) {
        await SecureStorage.putToken(responseModel: loginData);
        await SecureStorage.getToken();
        Future.delayed(
          const Duration(milliseconds: 500),
        ).then((value) => Get.off(const MainScreen()));
      } else {
        Get.snackbar(
          'Ошибка авторизации',
          "Неверный логин или пароль",
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
      }
    } catch (e) {
      print(e);
      print('error auth');
    }
    authorizing.value = false;
  }
}