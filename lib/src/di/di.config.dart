// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:awesome_notifications/awesome_notifications.dart' as _i5;
import 'package:dio/dio.dart' as _i6;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../domain/services/api/api_service.dart' as _i3;
import '../domain/services/api/api_service_impl.dart' as _i4;
import 'register_module.dart' as _i8;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.ApiService>(_i4.ApiServiceImpl());
  gh.singleton<_i5.AwesomeNotifications>(registerModule.notificationService);
  gh.singleton<_i6.Dio>(registerModule.httpClient);
  gh.singleton<_i7.FlutterSecureStorage>(registerModule.storage);
  return getIt;
}

class _$RegisterModule extends _i8.RegisterModule {}
