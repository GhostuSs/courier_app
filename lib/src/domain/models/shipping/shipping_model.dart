class ShippingModel {
  ShippingModel({
    this.addres_2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.phone,
    required this.first_name,
    required this.last_name,
    required this.company,
    this.addres_1,
  });
  final String first_name;
  final String last_name;
  final String company;
  final String? addres_1;
  final String? addres_2;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final String phone;

  static ShippingModel fromJson({required Map<String, dynamic> json}) =>
      ShippingModel(
        addres_2: json['addres_2'],
        city: json['city'],
        state: json['state'],
        postcode: json['postcode'],
        country: json['country'],
        phone: json['phone'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        company: json['company'],
        addres_1: json['addres_1'],
      );
}
