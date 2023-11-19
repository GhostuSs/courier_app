
import 'dart:async';

import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/res/config/api_routes.dart';
import 'package:courier_app/src/domain/models/auth/auth_request_model/auth_request_model.dart';
import 'package:courier_app/src/domain/models/auth/auth_response_model/auth_response_model.dart';
import 'package:courier_app/src/domain/services/secure_storage/secure_storage_service.dart';
import 'package:courier_app/src/presentation/ui/auth/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService{
  static const _historyKey = 'history';
  static const _newordersKey = 'new';
  static Dio get _dio =>Dio(
    BaseOptions(
      headers: {
        'Authorization':"Bearer ${SecureStorage.preloadedToken}"}
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
        "token":SecureStorage.preloadedToken,
        "orders_type":_newordersKey,
      };
      final response = await _dio.get(dotenv.env['URL']!+ApiRoute.orders,queryParameters: _params);
      final data = response.data;
      print(response.data);
      if(data.runtimeType==List&&data.isNotEmpty==true) {
        return data;
      }
    }on DioException catch(e){
      print('/orders');
      print(e);
      SecureStorage.clearData();
      Get.offAll(AuthScreen());
    }
  }
  static Future<List?> getHistory() async {
    try{
      final _params = {
        'per_page':20,
        'page':1,
        "consumer_key":dotenv.env['CONSUMER_KEY'],
        "consumer_secret":dotenv.env['CONSUMER_SECRET'],
        "token":SecureStorage.preloadedToken,
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
  static Future<bool?> acceptOrder({required int order_id}) async {
    try{
      final _params = {
        "token":await SecureStorage.getToken(),
        "order_id":order_id,
      };
      final response = await _dio.get(dotenv.env['URL']!+ApiRoute.acceptOrder,queryParameters: _params);
      if(response.statusCode==200) {
        return true;
      }else{
        return false;
      }
    }on DioException catch(e){
      print('/take_order');
      print(e);
    }
  }
  static Future<bool?> deliverOrder({required int order_id}) async {
    try{
      final _params = {
        "token":await SecureStorage.getToken(),
        "order_id":order_id,
      };
      final response = await _dio.get(dotenv.env['URL']!+ApiRoute.deliverOrder,queryParameters: _params);
      print(response.data);
      if(response.statusCode==200) {
        return true;
      }else{
        return false;
      }
    }on DioException catch(e){
      print('/finish_order');
      print(e);
    }
  }
}