import 'package:courier_app/src/domain/models/cart/merchant_item_model.dart';
import 'package:courier_app/src/domain/models/shipping/shipping_model.dart';

class OrderResponseModel {
  OrderResponseModel({
    required this.lineItems,
    required this.id,
    required this.parent_id,
    required this.status,
    required this.billing,
    required this.currency,
    required this.customer_note,
    this.date_created,
    this.date_paid,
    required this.payment_method,
    required this.payment_method_title,
    required this.shipping,
    required this.total,
    required this.number,
  });
  final int id;
  final int parent_id;
  final String status;
  final String currency;
  final double total;
  final int number;
  final Map<String, dynamic> billing;
  final ShippingModel shipping;
  final String payment_method;
  final String payment_method_title;
  final String customer_note;
  final DateTime? date_created;
  final DateTime? date_paid;
  final List<CartModel> lineItems;

  static OrderResponseModel fromJson({required Map<String, dynamic> json}) =>
      OrderResponseModel(
        id: json['id'],
        parent_id: json['parent_id'],
        status: json['status'],
        currency: json['currency'],
        total: double.tryParse(json['total']) ?? 0,
        billing: json['billing'],
        shipping: ShippingModel.fromJson(json: json['shipping']),
        payment_method: json['payment_method'],
        payment_method_title: json['payment_method_title'],
        customer_note: json['customer_note'],
        date_created: json['date_created'] != null
            ? _prepareDate(json['date_created'])
            : null,
        date_paid: json['date_paid'] != null
            ? DateTime.tryParse(json['date_paid'])
            : null,
        lineItems: List.generate((json['line_items'] ?? []).length, (index) => CartModel.fromJson(json: json['line_items'][index])),
        number: int.tryParse(json['number'])??0,
      );

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      "total": total,
      "date_paid": date_paid,
      "id": id,
    };
  }

  ///TODO: СДЕЛАЙ
  static DateTime _prepareDate(dynamic date) {
    print(date);
    if (DateTime.tryParse(date) != null) {
      return DateTime.parse(date);
    } else {
      return DateTime.parse(date['date'] + date['timezone']);
    }
  }
}
