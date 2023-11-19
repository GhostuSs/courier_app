
import 'package:courier_app/res/config/api_routes.dart';
import 'package:courier_app/src/domain/models/auth/auth_request_model/auth_request_model.dart';
import 'package:courier_app/src/domain/models/auth/auth_response_model/auth_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService{
  static const _historyKey = 'history';
  static const _newordersKey = 'new';
  static Dio get _dio =>Dio(
    BaseOptions(
      headers: {
        'Authorization':"Bearer ${dotenv.env['TOKEN']}"}
    )
  );

  static Future<AuthResponseModel?> login({required AuthRequestModel model}) async {
    try{
      final response = await _dio.get(dotenv.env['URL']!+ApiRoute.login,queryParameters: model.toJson());
      print(response.data);
      final data = AuthResponseModel.fromJson(json:response.data);
      return data;
    }on DioException catch(e){
      print('/login');
      print(e);
    }
  }

  static Future<List?> getOrders() async {
    try{
      final _params = {
        'per_page':20,
        'page':1,
        "consumer_key":dotenv.env['CONSUMER_KEY'],
        "consumer_secret":dotenv.env['CONSUMER_SECRET'],
        "token":dotenv.env['TOKEN'],
        "orders_type":_newordersKey,
      };
      final response = await _dio.get(dotenv.env['URL']!+ApiRoute.orders,queryParameters: _params);
      final data = response.data;
      if(data.runtimeType==List&&data.isNotEmpty==true) {
        return data;
      }
    }on DioException catch(e){
      print('/orders');
      print(e);
    }
  }
  static Future<List?> getHistory() async {
    try{
      final _params = {
        'per_page':20,
        'page':1,
        "consumer_key":dotenv.env['CONSUMER_KEY'],
        "consumer_secret":dotenv.env['CONSUMER_SECRET'],
        "token":dotenv.env['TOKEN'],
        "orders_type":_historyKey,
      };
      final response = await _dio.get(dotenv.env['URL']!+ApiRoute.orders,queryParameters: _params);
      final data = response.data;
      if(data.runtimeType==List&&data.isNotEmpty==true) {
        return data;
      }
    }on DioException catch(e){
      print('/orders');
      print(e);
    }
  }
}