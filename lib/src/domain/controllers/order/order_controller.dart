import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/models/order/order_response_model.dart';
import 'package:courier_app/src/domain/services/api/api_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {

  RxList<OrderResponseModel> orders = <OrderResponseModel>[].obs;
  RxList<OrderResponseModel> history = <OrderResponseModel>[].obs;
  RxSet<DateTime> historyPeriods = <DateTime>{}.obs;
  RxSet<DateTime> ordersPeriods = <DateTime>{}.obs;
  RxBool loadingOrders = true.obs;
  RxBool loadingHistory = true.obs;
  RxInt historyTabValue = 0.obs;

  Future<void> initialize() async {
    final orderData = await ApiService.getOrders()??[];
    for (final order in orderData) {
      final orderModel = OrderResponseModel.fromJson(json: order);
      orders.value.add(orderModel);
      if(orderModel.date_created!=null)ordersPeriods.add(DateUtils.dateOnly(orderModel.date_created!));
    }
    loadingOrders.value=false;
    final historyData = await ApiService.getHistory()??[];
    for (final order in historyData) {
      final orderModel = OrderResponseModel.fromJson(json: order);
      history.value.add(orderModel);
      if(orderModel.date_created!=null)historyPeriods.add(DateUtils.dateOnly(orderModel.date_created!));
    }
    loadingHistory.value=false;
  }

  int selectPeriod({required int value})=>historyTabValue.value=value;
}