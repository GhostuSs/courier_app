// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:awesome_notifications/awesome_notifications.dart' as _i1006;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../domain/services/api/api_service.dart' as _i1013;
import '../domain/services/api/api_service_impl.dart' as _i551;
import 'register_module.dart' as _i291;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i361.Dio>(() => registerModule.httpClient);
  gh.singleton<_i558.FlutterSecureStorage>(() => registerModule.storage);
  gh.singleton<_i1006.AwesomeNotifications>(
      () => registerModule.notificationService);
  gh.singleton<_i1013.ApiService>(() => _i551.ApiServiceImpl());
  return getIt;
}

class _$RegisterModule extends _i291.RegisterModule {}
