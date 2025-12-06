import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/shared/Loading/easy_loading.dart';
import 'package:e_commerce_app/core/shared/Loading/loading_message.dart';

class DioClientNetwork {
  static final DioClientNetwork _instance = DioClientNetwork._internal();
  late final Dio _dio;

  factory DioClientNetwork() {
    return _instance;
  }

  DioClientNetwork._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.75.16:7095/api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  static Future<Response> post(String path, {dynamic data, bool showLoading = true}) async {
    try {
      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.loading);
      }

      final response = await _instance._dio.post(path, data: data);

      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.dismiss);
      }

      return response;
    } catch (e) {
      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.dismiss);
        easyLoading('Request failed: $e', EasyLoadingEnum.error);
      }
      throw Exception('POST request failed: $e');
    }
  }

  static Future<Response> get(String path, {
    Map<String, dynamic>? queryParameters,
    bool showLoading = true
  }) async {
    try {
      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.loading);
      }

      final response = await _instance._dio.get(path, queryParameters: queryParameters);

      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.dismiss);
      }

      return response;
    } catch (e) {
      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.dismiss);
        easyLoading('Request failed: $e', EasyLoadingEnum.error);
      }
      throw Exception('GET request failed: $e');
    }
  }

  // Additional methods for PUT, DELETE, etc.

  static Future<Response> put(String path, {dynamic data, bool showLoading = true}) async {
    try {
      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.loading);
      }

      final response = await _instance._dio.put(path, data: data);

      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.dismiss);
      }

      return response;
    } catch (e) {
      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.dismiss);
        easyLoading('Request failed: $e', EasyLoadingEnum.error);
      }
      throw Exception('PUT request failed: $e');
    }
  }

  static Future<Response> delete(String path, {bool showLoading = true}) async {
    try {
      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.loading);
      }

      final response = await _instance._dio.delete(path);

      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.dismiss);
      }

      return response;
    } catch (e) {
      if (showLoading) {
        easyLoading(LOADING, EasyLoadingEnum.dismiss);
        easyLoading('Request failed: $e', EasyLoadingEnum.error);
      }
      throw Exception('DELETE request failed: $e');
    }
  }
}