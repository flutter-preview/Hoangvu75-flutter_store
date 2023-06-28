import 'dart:convert';

import 'package:dio/dio.dart';

import '../../utils/dialog_utils.dart';
import '../models/base_response.dart';

abstract class IBaseRepository {
  dynamic handleError(error) {
    switch (error.runtimeType) {
      case DioException:
        final response = BaseResponse.fromJson(const JsonDecoder().convert(error.response.toString()) as Map<String, dynamic>);
        DialogUtils.showNotificationDialog(title: "Server request error!", content: response.message!);

        break;
      default:
        DialogUtils.showNotificationDialog(title: "Server request error!", content: "Unknown error occurred. Please try again.");
        throw FormatException("Error: ", error);
    }
  }
}
