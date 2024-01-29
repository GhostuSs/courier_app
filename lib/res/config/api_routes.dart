abstract class ApiRoute {
  static const String login = '/courier/token';
  static const String orders = '/wc/v3/orders';
  static const String acceptOrder = '/courier/take_order';
  static const String deliverOrder = '/courier/finish_order';
  static const String earnings = '/courier/payments';
}
