import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/controllers/auth/auth_controller.dart';
import 'package:courier_app/src/presentation/uikit/raw_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  AuthController get controller => Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = AppLocale.of(context);

    return PopScope(
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top, horizontal: 16.w),
          child: Obx(() => controller.authorizing.value
              ? Center(
            child: CircularProgressIndicator(
              color: AppColors.red,
            ),
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    locale.auth,
                    style: theme.textTheme.displayMedium,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controller.loginController,
                    cursorColor: AppColors.black,
                    onChanged: (_) => controller.onChange(),
                    decoration: InputDecoration(labelText: locale.yourEmail),
                  ),
                  const SizedBox(height: 24),
                  Obx(
                        () => TextField(
                      controller: controller.passController,
                      cursorColor: AppColors.black,
                      obscureText: controller.obscurePass.value,
                      obscuringCharacter: '*',
                      onChanged: (_) => controller.onChange(),
                      decoration: InputDecoration(
                        labelText: locale.yourPass,
                        suffixIconColor: AppColors.gray1,
                        suffixIconConstraints: BoxConstraints.tightFor(width: 40.w),
                        suffixIcon: InkWell(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () => controller.changeObscuring(),
                          child: Icon(controller.obscurePass.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                    () => RawButton(
                  label: locale.login,
                  onTap: () => controller.authorize(),
                  active: controller.entryEnabled.value,
                ),
              ),
            ],
          )),
        ),
      ),
      canPop: false,
    );
  }
}