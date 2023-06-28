import 'package:dio/dio.dart';
import 'package:hitek_test/data/models/base_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_api.g.dart';

@RestApi()
abstract class RestAPI {
  factory RestAPI(Dio dio, {String baseUrl}) = _RestAPI;

  // Auth
  @POST("/auth/login")
  Future<BaseResponse> login(@Body() Map<String, dynamic> body);
}

// flutter packages pub run build_runner build --delete-conflicting-outputs
