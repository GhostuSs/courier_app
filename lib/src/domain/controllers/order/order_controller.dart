import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/models/order/order_response_model.dart';
import 'package:courier_app/src/domain/models/order/statuses/order_statuses_model.dart';
import 'package:courier_app/src/domain/services/api/api_service.dart';

class OrderController extends GetxController {
  RxList<OrderResponseModel> orders = <OrderResponseModel>[].obs;
  RxList<OrderResponseModel> history = <OrderResponseModel>[].obs;
  RxSet<DateTime> historyPeriods = <DateTime>{}.obs;
  RxSet<String> statuses = <String>{}.obs;
  RxBool loadingOrders = true.obs;
  RxBool loadingHistory = true.obs;
  RxInt historyTabValue = 0.obs;
  Rx<OrderResponseModel> selectedOrder = OrderResponseModel.empty().obs;

  Future<void> initialize() async {
    await getOrders();
    await getHistory();
  }

  Future<void> getOrders() async {
    loadingOrders.value = true;
    statuses.value = {};
    orders.value = [];
    final orderData = await ApiService.getOrders() ?? [];
    for (final order in orderData) {
      final orderModel = OrderResponseModel.fromJson(json: order);
      if (orderModel.status != OrderStatuses.completed &&
          orderModel.status != OrderStatuses.trash) {
        orders.value.add(orderModel);
        statuses.add(orderModel.status);
      }
    }
    if (orders.isNotEmpty) selectedOrder.value = orders.value.first;
    loadingOrders.value = false;
  }

  Future<void> getHistory() async {
    loadingHistory.value = true;
    history.value = [];
    final historyData = await ApiService.getHistory() ?? [];
    for (final order in historyData) {
      final orderModel = OrderResponseModel.fromJson(json: order);
      print(orderModel.status);
      if (orderModel.status == OrderStatuses.completed) {
        history.value.add(orderModel);
        if (orderModel.date_created != null)
          historyPeriods.add(DateUtils.dateOnly(orderModel.date_created!));
      }
    }
    loadingHistory.value = false;
  }

  int selectPeriod({required int value}) {
    return historyTabValue.value = value;
  }

  void selectOrder({required OrderResponseModel order}) =>
      selectedOrder.value = order;

  Future<void> handleOrderStatus() async {
    if (selectedOrder.value.status != OrderStatuses.courier) {
      if (await ApiService.acceptOrder(order_id: selectedOrder.value.id) ==
          true) {
        selectedOrder.value.status = OrderStatuses.courier;
        await getOrders();
      }
    } else {
      if (await ApiService.deliverOrder(order_id: selectedOrder.value.id) ==
          true) {
        selectedOrder.value.status = OrderStatuses.completed;
        await getOrders();
      }
    }
  }
}
