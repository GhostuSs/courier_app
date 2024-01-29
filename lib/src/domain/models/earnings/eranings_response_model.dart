
import 'package:courier_app/src/domain/models/order/short_order_response_model/short_order_response_model.dart';

class EarningResponseModel{
  final DateTime date;
  final List<ShortOrderResponseModel> orders;
  final double total;
  EarningResponseModel({
    required this.date,
    required this.orders,
    required this.total,
  });


  factory EarningResponseModel.fromJson({required Map<String, dynamic> json}) {
    final orders = json['orders'] as List;
    final ordersList = orders.map((e) => ShortOrderResponseModel.fromJson(json: e)).toSet().toList();
    return EarningResponseModel(
      date: json['create_date'],
      orders: ordersList,
      total: double.tryParse(json['total']) ?? 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is EarningResponseModel && runtimeType == other.runtimeType && date == other.date;

  @override
  int get hashCode => date.hashCode;
}