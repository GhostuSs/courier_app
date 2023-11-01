import 'package:courier_app/src/domain/models/order/order_response_model.dart';
import 'package:courier_app/src/domain/services/api/api_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {

  RxList<OrderResponseModel> orders = <OrderResponseModel>[].obs;

  Future<void> initialize() async {
    final data = await ApiService.getOrders()??[];
    for (final order in data) {
      orders.value.add(OrderResponseModel.fromJson(json: order));
    }
  }
}