class CartModel {
  CartModel({
    required this.id,
    required this.name,
    required this.product_id,
    required this.quantity,
    required this.subtotal,
    required this.total,
    required this.image,
  });
  final int id;
  final String name;
  final int product_id;
  final int quantity;
  final double subtotal;
  final double total;
  final String image;

  static CartModel fromJson({required Map<String, dynamic> json}) =>
      CartModel(
        id: json['id'],
        name: json['name'],
        product_id: json['product_id'],
        quantity: json['quantity'],
        subtotal: double.parse(json['subtotal']),
        total: double.parse(json['total']),
        image: json['image']['src'],
      );
}
