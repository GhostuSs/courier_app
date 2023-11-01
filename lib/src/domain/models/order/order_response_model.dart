class OrderResponseModel{
  OrderResponseModel({required this.id,required this.parent_id,required this.status,required this.billing,required this.currency,required this.customer_note,this.date_completed,this.date_paid,required this.payment_method,required this.payment_method_title,required this.shipping,required this.total,});
  final int id;
  final int parent_id;
  final String status;
  final String currency;
  final double total;
  final Map<String,dynamic> billing;
  final Map<String,dynamic> shipping;
  final String payment_method;
  final String payment_method_title;
  final String customer_note;
  final DateTime? date_completed;
  final DateTime? date_paid;

  static OrderResponseModel fromJson({required Map<String,dynamic> json})=>OrderResponseModel(
    id: json['id'],
    parent_id: json['parent_id'],
    status: json['status'],
    currency: json['currency'],
    total: double.tryParse(json['total']) ?? 0,
    billing: json['billing'],
    shipping: json['shipping'],
    payment_method: json['payment_method'],
    payment_method_title: json['payment_method_title'],
    customer_note: json['customer_note'],
    date_completed: json['date_completed']!=null ? DateTime.tryParse(json['date_completed']) : null,
    date_paid: json['date_paid']!=null ?DateTime.tryParse(json['date_paid']): null,
  );

}