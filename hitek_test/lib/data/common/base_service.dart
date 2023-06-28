import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:hitek_test/common/config/app_constants.dart';
import 'package:hitek_test/data/common/rest_api.dart';

class BaseService {
  late RestAPI client;
  final Dio _dio = Dio();

  final _baseUrl = API_HOST + API_PREFIX;
  static String? accessToken;

  BaseService() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _dio.interceptors.add(
      LogInterceptor(
        responseHeader: false,
        responseBody: true,
        request: true,
        requestBody: true,
      ),
    );
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          if (accessToken != null) {
            options.headers['Authorization'] = "Bearer $accessToken";
          }
          handler.next(options);
        },
      ),
    );

    client = RestAPI(
      _dio,
      baseUrl: _baseUrl,
    );
  }
}
