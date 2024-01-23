import 'package:courier_app/src/di/di.dart';
import 'package:courier_app/src/domain/services/api/api_service.dart';
import 'package:courier_app/src/presentation/ui/orders/orders_screen.dart';
import 'package:courier_app/src/presentation/ui/profile/profile_screen.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currIndex = 0.obs;
  static const screens = [
    OrdersScreen(),
    ProfileScreen(),
  ];

  void changeIndex({required int index}) => currIndex.value = index;

  Future<void> initialize() async {
    await getIt<ApiService>().getOrders();
  }
}
