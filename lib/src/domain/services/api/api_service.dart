import 'package:courier_app/src/domain/models/auth/auth_request_model/auth_request_model.dart';
import 'package:courier_app/src/domain/models/auth/auth_response_model/auth_response_model.dart';
import 'package:courier_app/src/domain/models/earnings/eranings_response_model.dart';
abstract class ApiService {
  Future<AuthResponseModel?> login({required AuthRequestModel model});

  Future<List?> getOrders();

  Future<List?> getHistory();

  Future<bool?> acceptOrder({required int order_id});

  Future<bool?> deliverOrder({required int order_id});

  Future getMe();

  Future<List<EarningResponseModel>?> getEarnings();

  Future<void> saveToken({required String token});
}
