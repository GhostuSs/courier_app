import 'dart:async';

import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/di/di.dart';
import 'package:courier_app/src/domain/enums/orders_filter.dart';
import 'package:courier_app/src/domain/models/order/order_response_model.dart';
import 'package:courier_app/src/domain/models/order/statuses/order_statuses_model.dart';
import 'package:courier_app/src/domain/services/api/api_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class OrderController extends GetxController {
  RxList<OrderResponseModel> orders = <OrderResponseModel>[].obs;
  RxList<OrderResponseModel> history = <OrderResponseModel>[].obs;
  RxSet<DateTime> historyPeriods = <DateTime>{}.obs;
  RxSet<String> statuses = <String>{}.obs;
  RxBool loadingOrders = true.obs;
  RxBool loadingHistory = true.obs;
  late RxInt historyTabValue = 0.obs;
  /// Фильтр на таб
  Rx<OrdersFilter> filter = OrdersFilter.day.obs;
  ///Выбранная дата под табом
  Rx<DateTime> currentDate = DateUtils.dateOnly(DateTime.now()).obs;
  late Timer timer;
  final _apiService = getIt<ApiService>();
  Rx<OrderResponseModel> selectedOrder = OrderResponseModel.empty().obs;

  Future<void> initialize() async {
    historyTabValue.value=filter.value.fromEnumToTabValue();
    await getOrders();
    await getHistory();
    final InternetConnection connection = InternetConnection();
    timer = Timer.periodic(Duration(seconds:60),(_) async =>await connection.hasInternetAccess ? loadOrders() : null);
  }

  Future<void> getOrders() async {
    print('get orders');
    loadingOrders.value = true;
    statuses.value = {};
    _apiService.getEarnings();
    orders.value = [];
    await loadOrders();
    if (orders.isNotEmpty) selectedOrder.value = orders.value.first;
    loadingOrders.value = false;
  }

  Future<void> loadOrders()async {
    final orderData = await _apiService.getOrders() ?? [];
    orders.clear();
    for (final order in orderData) {
      final orderModel = OrderResponseModel.fromJson(json: order);
      if (orderModel.status != OrderStatuses.completed &&
          orderModel.status != OrderStatuses.trash) {
        orders.value.add(orderModel);
        statuses.add(orderModel.status);
      }
    }
  }

  Future<void> getHistory() async {
    loadingHistory.value = true;
    history.value = [];
    final historyData = await _apiService.getHistory() ?? [];
    for (final order in historyData) {
      final orderModel = OrderResponseModel.fromJson(json: order);
      if (orderModel.status == OrderStatuses.completed) {
        history.value.add(orderModel);
        if (orderModel.date_created != null)
          historyPeriods.add(DateUtils.dateOnly(orderModel.date_created!));
      }
    }
    loadingHistory.value = false;
  }

  int selectPeriod({required int value}) {
    filter.value=value.fromIntToEnum(value:value ?? 0);
    return historyTabValue.value = value;
  }

  void selectOrder({required OrderResponseModel order}) =>
      selectedOrder.value = order;

  Future<void> handleOrderStatus() async {
    if (selectedOrder.value.status != OrderStatuses.courier) {
      if (await _apiService.acceptOrder(order_id: selectedOrder.value.id) ==
          true) {
        selectedOrder.value.status = OrderStatuses.courier;
        await getOrders();
      }
    } else {
      if (await _apiService.deliverOrder(order_id: selectedOrder.value.id) ==
          true) {
        selectedOrder.value.status = OrderStatuses.completed;
        await getOrders();
      }
    }
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
