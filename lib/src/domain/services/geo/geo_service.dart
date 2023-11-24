import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/presentation/ui/auth/uikit/error_screen.dart';
import 'package:geolocator/geolocator.dart';

///Сервис геолокации
class GeoService {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.to(const ErrorScreen(
        type: ErrorType.noGeo,
      ));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.to(const ErrorScreen(
          type: ErrorType.noGeo,
        ));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.to(const ErrorScreen(
        type: ErrorType.noGeo,
      ));
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<void> openSettings() async {
    Geolocator.openAppSettings();
  }
}
