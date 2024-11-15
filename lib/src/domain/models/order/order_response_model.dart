import 'package:courier_app/src/domain/models/cart/merchant_item_model.dart';
import 'package:courier_app/src/domain/models/order/statuses/order_statuses_model.dart';
import 'package:courier_app/src/domain/models/shipping/shipping_model.dart';

class OrderResponseModel {
  OrderResponseModel({
    required this.lineItems,
    required this.id,
    required this.parent_id,
    required this.status,
    required this.currency,
    required this.customer_note,
    this.date_created,
    this.date_paid,
    required this.payment_method,
    required this.payment_method_title,
    required this.shipping,
    required this.total,
    required this.number,
    this.latitude,
    this.longtitude,
    this.address_1,
    this.phone,
  });
  final int id;
  final int parent_id;
  String status;
  final String currency;
  final double total;
  final int number;
  final ShippingModel shipping;
  final String payment_method;
  final String payment_method_title;
  final String customer_note;
  final DateTime? date_created;
  final DateTime? date_paid;
  final List<CartModel> lineItems;
  final double? latitude;
  final double? longtitude;
  final String? address_1;
  final String? phone;

  static OrderResponseModel fromJson({required Map<String, dynamic> json}) {
    double? lat;
    double? long;

    final billing = json['billing'];
    (json['meta_data']).asMap().forEach((key, value) {
      if (value['key'] == 'lat') {
        lat = double.tryParse(value['value']);
      } else {
        if (value['key'] == 'long') {
          long = double.tryParse(value['value']);
        }
      }
    });
    return OrderResponseModel(
        id: json['id'],
        parent_id: json['parent_id'],
        status: json['status'],
        currency: json['currency'],
        address_1: (billing['state'] ?? '') + ", " + (billing['city'] ?? '') + ", " + (billing['address_1'] ?? ''),
        total: double.tryParse(json['total']) ?? 0,
        shipping: ShippingModel.fromJson(json: json['shipping']),
        payment_method: json['payment_method'],
        payment_method_title: json['payment_method_title'],
        customer_note: json['customer_note'],
        date_created: json['date_created'] != null ? _prepareDate(json['date_created']) : null,
        date_paid: json['date_paid'] != null ? DateTime.tryParse(json['date_paid']) : null,
        lineItems: List.generate(
            (json['line_items'] ?? []).length, (index) => CartModel.fromJson(json: json['line_items'][index])),
        number: int.tryParse(json['number']) ?? 0,
        latitude: lat,
        longtitude: long,
        phone: billing['phone']);
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'total': total,
      'date_paid': date_paid,
      'id': id,
    };
  }

  OrderResponseModel copyWith(
      {int? id,
      int? parent_id,
      String? status,
      String? currency,
      String? address_1,
      double? total,
      ShippingModel? shipping,
      String? payment_method,
      String? payment_method_title,
      String? customer_note,
      DateTime? date_created,
      DateTime? date_paid,
      List<CartModel>? lineItems,
      int? number,
      double? latitude,
      double? longtitude,
      String? phone}
      ) {
    return OrderResponseModel(
        id: id ?? this.id,
        parent_id:parent_id ?? this.parent_id,
        status: status ?? this.status,
        currency: currency ?? this.currency,
        address_1: address_1 ?? this.address_1,
        total: total ?? this.total,
        shipping: shipping ?? this.shipping,
        payment_method: payment_method ?? this.payment_method,
        payment_method_title: payment_method_title ?? this.payment_method_title,
        customer_note: customer_note ?? this.customer_note,
        date_created: date_created ?? this.date_created,
        date_paid: date_paid ?? this.date_paid,
        lineItems: lineItems ?? this.lineItems,
        number: number ?? this.number,
        latitude: latitude ?? this.latitude,
        longtitude: longtitude ?? this.longtitude,
        phone: phone ?? this.phone,
    );
  }

  static OrderResponseModel empty() => OrderResponseModel(
      lineItems: [],
      id: 0,
      parent_id: 0,
      status: OrderStatuses.completed,
      currency: '',
      customer_note: '',
      payment_method: '',
      payment_method_title: '',
      shipping: ShippingModel(
        city: '',
        state: '',
        postcode: '',
        country: '',
        phone: '',
        first_name: '',
        last_name: '',
        company: '',
      ),
      total: 0,
      number: 0);

  ///TODO: СДЕЛАЙ
  static DateTime _prepareDate(dynamic date) {
    if (DateTime.tryParse(date) != null) {
      return DateTime.parse(date);
    } else {
      return DateTime.parse(date['date'] + date['timezone']);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OrderResponseModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
