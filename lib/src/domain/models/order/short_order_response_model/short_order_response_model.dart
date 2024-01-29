class ShortOrderResponseModel{
  final int id;
  final DateTime date_created;
  final int order_products_count;
  final double order_total;
  final double courier_payment;
  ShortOrderResponseModel({
    required this.id,
    required this.date_created,
    required this.order_products_count,
    required this.order_total,
    required this.courier_payment,
  });

  // fromJson
  factory ShortOrderResponseModel.fromJson({required Map<String, dynamic> json}) {
    return ShortOrderResponseModel(
      id: json['order_id'],
      date_created: DateTime.parse(json['create_date']),
      order_products_count: json['order_products_count'],
      order_total: double.tryParse(json['order_total']) ?? 0,
      courier_payment: double.tryParse(json['courier_payment']) ?? 0,
    );
  }
}