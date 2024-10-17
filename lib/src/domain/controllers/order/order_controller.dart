import 'dart:async';

import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/di/di.dart';
import 'package:courier_app/src/domain/enums/orders_filter.dart';
import 'package:courier_app/src/domain/models/earnings/eranings_response_model.dart';
import 'package:courier_app/src/domain/models/order/order_response_model.dart';
import 'package:courier_app/src/domain/models/order/statuses/order_statuses_model.dart';
import 'package:courier_app/src/domain/services/api/api_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class OrderController extends GetxController {
  RxList<OrderResponseModel> orders = <OrderResponseModel>[].obs;
  RxList<OrderResponseModel> history = <OrderResponseModel>[].obs;
  RxList<EarningResponseModel> orderEarnings = <EarningResponseModel>[].obs;
  RxSet<String> statuses = <String>{}.obs;
  RxBool loadingOrders = true.obs;
  RxBool enableLoader = false.obs;
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
    historyTabValue.value = filter.value.fromEnumToTabValue();
    await getOrders();
    await getHistory();
    final InternetConnection connection = InternetConnection();
    timer =
        Timer.periodic(Duration(seconds: 60), (_) async => await connection.hasInternetAccess ? loadOrders() : null);
  }

  Future<void> getOrders() async {
    print('get orders');
    loadingOrders.value = true;
    statuses.value = {};
    orders.value = [];
    await loadOrders();
    if (orders.isNotEmpty) selectedOrder.value = orders.value.first;
    loadingOrders.value = false;
  }

  Future<void> loadOrders() async {
    final orderData = await _apiService.getOrders() ?? [];
    orders.clear();
    for (final order in orderData) {
      final orderModel = OrderResponseModel.fromJson(json: order);
      if (orderModel.status != OrderStatuses.completed && orderModel.status != OrderStatuses.trash) {
        orders.value.add(orderModel);
        statuses.add(orderModel.status);
      }
      orders.toSet().toList();
    }
  }

  Future<void> getHistory() async {
    loadingHistory.value = true;
    history.value = [];
    final historyData = await _apiService.getHistory() ?? [];
    await getOrderEarnings();
    for (final order in historyData.toSet()) {
      final orderModel = OrderResponseModel.fromJson(json: order);
      if (orderModel.status == OrderStatuses.completed) {
        history.value.add(orderModel);
      }
    }
    history.toSet().toList();
    loadingHistory.value = false;
  }

  int selectPeriod({required int value}) {
    filter.value = value.fromIntToEnum(value: value);
    currentDate.value = DateUtils.dateOnly(DateTime.now());
    return historyTabValue.value = value;
  }

  void selectOrder({required OrderResponseModel order}) => selectedOrder.value = order;

  Future<void> handleOrderStatus(BuildContext context) async {
    enableLoader.value = true;
    if (selectedOrder.value.status != OrderStatuses.courier) {
      if (await _apiService.acceptOrder(order_id: selectedOrder.value.id) == true) {
        selectedOrder.value.status = OrderStatuses.courier;
        Get.snackbar(
          'Статус заказа обновился',
          'Заказ успешно взят в доставку',
          colorText: AppColors.white,
          icon: Icon(
            Icons.check,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.green.withOpacity(0.8),
        );
        await getOrders();
      }
    } else {
      if (await _apiService.deliverOrder(order_id: selectedOrder.value.id) == true) {
        selectedOrder.value.status = OrderStatuses.completed;
        Navigator.of(context).pop();
        Get.snackbar(
          'Завершено',
          'Заказ успешно доставлен',
          colorText: AppColors.white,
          icon: Icon(
            Icons.check,
            color: AppColors.white,
          ),
          backgroundColor: AppColors.green.withOpacity(0.8),
        );

        await getOrders();
      }
    }
    enableLoader.value = false;
  }

  Future<void> getOrderEarnings() async {
    orderEarnings.value = [];
    final earningsData = await _apiService.getEarnings() ?? [];
    orderEarnings.value = earningsData.toList();
  }

  void previousPeriod() {
    if (filter.value == OrdersFilter.day) {
      currentDate.value = currentDate.value.subtract(Duration(days: 1));
    } else {
      if (filter.value == OrdersFilter.month) {
        currentDate.value = DateTime(currentDate.value.year, currentDate.value.month - 1, currentDate.value.day);
      } else {
        if (filter.value == OrdersFilter.week) {
          currentDate.value = currentDate.value.subtract(Duration(days: 7));
        }
      }
    }
  }

  void nextPeriod() {
    if (filter.value == OrdersFilter.day) {
      currentDate.value = currentDate.value.add(Duration(days: 1));
    } else {
      if (filter.value == OrdersFilter.month) {
        currentDate.value = DateTime(currentDate.value.year, currentDate.value.month + 1, currentDate.value.day);
      } else {
        if (filter.value == OrdersFilter.week) {
          currentDate.value = currentDate.value.add(Duration(days: 7));
        }
      }
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
