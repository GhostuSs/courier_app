import 'dart:io';

import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/services/geo/geo_service.dart';
import 'package:courier_app/src/presentation/uikit/raw_button.dart';
import 'package:restart_app/restart_app.dart';

class ErrorScreen extends StatelessWidget {
  final ErrorType type;
  const ErrorScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.symmetric(
              horizontal: 16, vertical: MediaQuery.of(context).padding.bottom),
          child: Column(
            children: [
              if (ErrorType.noInternet == type) const _NoInternetBody(),
              if (ErrorType.noGeo == type) const _NoGeoBody(),
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}

enum ErrorType {
  noInternet,
  noGeo,
}

class _NoInternetBody extends StatelessWidget {
  const _NoInternetBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = AppLocale.of(context);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Column(
            children: [
              Assets.images.noInternet.svg(width: 56.w),
              const SizedBox(height: 32),
              Text(
                'Кажется, нет интернета',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  text:
                      'Проверьте сеть и перезагрузите приложение – это должно помочь',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              RawButton(
                  label: locale.retry, onTap: Restart.restartApp, active: true),
              const SizedBox(height: 16),
              RawButton(
                  label: locale.exit,
                  customColor: AppColors.gray2,
                  invertTextColor: true,
                  onTap: () => exit(1),
                  active: true)
            ],
          )
        ],
      ),
    );
  }
}

class _NoGeoBody extends StatelessWidget {
  const _NoGeoBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = AppLocale.of(context);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Column(
            children: [
              Assets.images.geo.svg(width: 56.w),
              const SizedBox(height: 32),
              Text(
                'Включите геолокацию',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  text:
                      'Геолокация нужна, чтобы отслеживать вашу позицию на карте. Без этого приложение не будет работать',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              RawButton(
                  label: locale.openSettings,
                  onTap: GeoService.openSettings,
                  active: true),
            ],
          )
        ],
      ),
    );
  }
}
