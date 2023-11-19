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
  void onChange({String? login,String?pass}){
    if(login!=null)this.login.value=login;
    if(pass!=null)this.pass.value=pass;
    entryEnabled.value = EmailValidator.validate(this.login.value) && this.pass.value.length >= 6;
  }

  void changeObscuring()=>obscurePass.value=!obscurePass.value;

  Future<void> authorize() async {
    final AuthRequestModel model = AuthRequestModel(email: login.value, password: pass.value);
    final loginData = await ApiService.login(model: model);
    print("LOGINDATA");
    print(loginData?.token);
    if(loginData!=null){
      await SecureStorage.putToken(responseModel: loginData);
      await SecureStorage.getToken();
      Get.to(MainScreen());
        }
  }
}
