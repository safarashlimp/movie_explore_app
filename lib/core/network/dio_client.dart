import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../constants/api_constants.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        queryParameters: {'api_key': ApiConstants.apiKey},
        headers: {'Content-Type': 'application/json'},
      ),
    );
    _addInterceptors();
  }

  void _addInterceptors() {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      requestHeader: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      logPrint: (o) => debugPrint('[DIO] $o'),
    ));
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          handler.next(e);
        },
      ),
    );
  }
}
