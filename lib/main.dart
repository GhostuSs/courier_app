import 'package:courier_app/res/localization/l10n.dart';
import 'package:courier_app/res/theme/themes.dart';
import 'package:courier_app/src/domain/controllers/auth_controller.dart';
import 'package:courier_app/src/domain/controllers/main_controller.dart';
import 'package:courier_app/src/domain/controllers/order/order_controller.dart';
import 'package:courier_app/src/presentation/ui/loading/load_screen.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "config.env");
  FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 90));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (c, _) => GetMaterialApp(
        title: 'Суши и Пицца',
        theme: AppTheme.mainTheme,
        initialBinding: _bindings(),
        localizationsDelegates: const [
          AppLocale.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocale.delegate.supportedLocales,
        home: const LoadingScreen(),
      ),
    );
  }

  BindingsBuilder _bindings() => BindingsBuilder(() {
        Get
          ..lazyPut(() => OrderController(),fenix: true)
          ..lazyPut(() => AuthController(), fenix: true)
          ..lazyPut(() => MainController(), fenix: true);
        ;
      });
}
