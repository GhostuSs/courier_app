import 'package:courier_app/src/di/di.dart';
import 'package:courier_app/src/domain/models/auth/auth_request_model/auth_request_model.dart';
import 'package:courier_app/src/domain/services/api/api_service.dart';
import 'package:courier_app/src/domain/services/secure_storage/secure_storage_service.dart';
import 'package:courier_app/src/presentation/ui/main/main_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxString login = ''.obs;
  RxString pass = ''.obs;
  RxBool entryEnabled = false.obs;
  RxBool obscurePass = true.obs;
  RxBool authorizing = false.obs;
  void onChange({String? login, String? pass}) {
    if (login != null) this.login.value = login;
    if (pass != null) this.pass.value = pass;
    entryEnabled.value = EmailValidator.validate(this.login.value) && this.pass.value.length >= 6;
  }

  void changeObscuring() => obscurePass.value = !obscurePass.value;

  Future<void> authorize() async {
    authorizing.value = true;
    final model = AuthRequestModel(email: login.value, password: pass.value);
    try {
      final loginData = await getIt<ApiService>().login(model: model) ?? null;
      print(loginData);
      if (loginData != null) {
        await SecureStorage.putToken(responseModel: loginData);
        await SecureStorage.getToken();
        Future.delayed(const Duration(milliseconds: 500)).then(
          (value) => Get.to(
            const MainScreen(),
          ),
        );
      }
    } on Exception catch (e) {
      print(e);
      print('error auth');
    }
    authorizing.value = false;
  }
}
