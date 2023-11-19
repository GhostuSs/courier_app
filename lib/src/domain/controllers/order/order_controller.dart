import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/models/order/order_response_model.dart';
import 'package:courier_app/src/domain/services/api/api_service.dart';

class OrderController extends GetxController {

  RxList<OrderResponseModel> orders = <OrderResponseModel>[].obs;
  RxList<OrderResponseModel> history = <OrderResponseModel>[].obs;
  RxSet<DateTime> historyPeriods = <DateTime>{}.obs;
  RxSet<String> statuses = <String>{}.obs;
  RxBool loadingOrders = true.obs;
  RxBool loadingHistory = true.obs;
  RxInt historyTabValue = 0.obs;

  Future<void> initialize() async {
    loadingOrders.value=true;
    orders.value=[];
    history.value=[];
    final orderData = await ApiService.getOrders()??[];
    for (final order in orderData) {
      final orderModel = OrderResponseModel.fromJson(json: order);
      orders.value.add(orderModel);
      statuses.add(orderModel.status);
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

  int selectPeriod({required int value}) {
    return historyTabValue.value = value;
  }

}