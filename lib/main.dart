import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:courier_app/res/localization/l10n.dart';
import 'package:courier_app/res/theme/themes.dart';
import 'package:courier_app/src/di/di.dart';
import 'package:courier_app/src/domain/controllers/auth/auth_controller.dart';
import 'package:courier_app/src/domain/controllers/main/main_controller.dart';
import 'package:courier_app/src/domain/controllers/order/order_controller.dart';
import 'package:courier_app/src/domain/services/secure_storage/secure_storage_service.dart';
import 'package:courier_app/src/presentation/ui/loading/load_screen.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'config.env');
  await configureDependencies(Environment.prod);
  getIt<AwesomeNotifications>().initialize(null, [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        )
  ]);
  await SecureStorage.getToken();
  _initFirebase();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 90));
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  getIt<AwesomeNotifications>().initialize(null, [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
    )
  ]);
  getIt<AwesomeNotifications>().createNotificationFromJsonData(message.data);
  log('Handling a background message ${message.messageId}');
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
          ..lazyPut(OrderController.new, fenix: true)
          ..lazyPut(AuthController.new, fenix: true)
          ..lazyPut(MainController.new, fenix: true);
      });
}

Future<void> _initFirebase() async {
  try {
    await Firebase.initializeApp();
    AwesomeNotifications().requestPermissionToSendNotifications();
    FirebaseMessaging.instance.requestPermission(alert: true, announcement: true, carPlay: true, criticalAlert: true);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } on Exception catch (e) {
    log(e.toString());
  }
}
