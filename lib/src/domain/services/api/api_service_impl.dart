import 'dart:async';
import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/res/config/api_routes.dart';
import 'package:courier_app/src/di/di.dart';
import 'package:courier_app/src/domain/models/auth/auth_request_model/auth_request_model.dart';
import 'package:courier_app/src/domain/models/auth/auth_response_model/auth_response_model.dart';
import 'package:courier_app/src/domain/models/earnings/eranings_response_model.dart';
import 'package:courier_app/src/domain/models/order/short_order_response_model/short_order_response_model.dart';
import 'package:courier_app/src/domain/services/secure_storage/secure_storage_service.dart';
import 'package:courier_app/src/presentation/ui/auth/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import 'package:courier_app/src/domain/services/api/api_service.dart';

@Singleton(as: ApiService)
class ApiServiceImpl extends ApiService {
  static const _historyKey = 'history';
  static const _newordersKey = 'new';
  static Dio get _dio => getIt<Dio>();

  @override
  Future<AuthResponseModel?> login({
    required AuthRequestModel model,
  }) async {
    try {
      final response = await _dio.get(dotenv.env['URL']! + ApiRoute.login, queryParameters: model.toJson());
      final data = AuthResponseModel.fromJson(json: response.data);
      return data;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('/login');
        print(e);
      }
      return null;
    }
  }

  @override
  Future<List?> getOrders() async {
    try {
      final _params = {
        'per_page': 20,
        'page': 1,
        'consumer_key': dotenv.env['CONSUMER_KEY'],
        'consumer_secret': dotenv.env['CONSUMER_SECRET'],
        'token': SecureStorage.preloadedToken,
        'orders_type': _newordersKey,
      };
      final response = await _dio.get(dotenv.env['URL']! + ApiRoute.orders, queryParameters: _params);
      final data = response.data;
      if (data.runtimeType == List && data.isNotEmpty == true) {
        return data;
      }
    } on DioException catch (e) {
      print('/orders');
      print(e);
      await SecureStorage.clearData();
      await Get.offAll(const AuthScreen());
    }
    return null;
  }

  @override
  Future<List?> getHistory() async {
    try {
      final _params = {
        'per_page': 20,
        'page': 1,
        'consumer_key': dotenv.env['CONSUMER_KEY'],
        'consumer_secret': dotenv.env['CONSUMER_SECRET'],
        'token': SecureStorage.preloadedToken,
        'orders_type': _historyKey,
      };
      final response = await _dio.get(dotenv.env['URL']! + ApiRoute.orders, queryParameters: _params);
      final data = response.data;
      if (data.runtimeType == List && data.isNotEmpty == true) {
        return data;
      }
    } on DioException catch (e) {
      print('/orders');
      print(e);
    }
    return null;
  }

  @override
  Future<bool?> acceptOrder({required int order_id}) async {
    try {
      final _params = {
        'token': await SecureStorage.getToken(),
        'order_id': order_id,
      };
      final response = await _dio.get(dotenv.env['URL']! + ApiRoute.acceptOrder, queryParameters: _params);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print('/take_order');
      print(e);
    }
    return null;
  }

  @override
  Future<bool?> deliverOrder({required int order_id}) async {
    try {
      final _params = {
        'token': await SecureStorage.getToken(),
        'order_id': order_id,
      };
      final response = await _dio.get(dotenv.env['URL']! + ApiRoute.deliverOrder, queryParameters: _params);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print('/finish_order');
      print(e);
    }
    return null;
  }

  @override
  Future getMe() async {
    _dio.get(
      dotenv.env['URL']! + ApiRoute.deliverOrder,
    );
  }

  @override
  Future<List<EarningResponseModel>?> getEarnings() async {
    try {
      final response = await _dio.get(
        dotenv.env['URL']! + ApiRoute.earnings,
        queryParameters: {
          'token': SecureStorage.preloadedToken,
        },
      );
      print(response.data);
      List<EarningResponseModel> list = _convertToList(json: response.data);
      return list;
    } on Exception catch (e) {
      print('/getEarnings');
      debugPrint(e.toString());
      return null;
    }
    return null;
  }

  List<EarningResponseModel> _convertToList({required Map<String, dynamic> json}) {
    List<EarningResponseModel> earningList = [];
    for (final value in json.entries) {
      final date = value.key;
      final orders = value.value['orders'] as List;
      final ordersList = orders.map((e) => ShortOrderResponseModel.fromJson(json: e)).toList();
      final total = double.tryParse(value.value['total']) ?? 0;
      final earning = EarningResponseModel(
        date: DateTime.parse(date),
        orders: ordersList,
        total: total,
      );
      earningList.add(earning);
    }
    return earningList;
  }
}
