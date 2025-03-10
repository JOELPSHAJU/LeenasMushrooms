import 'package:dio/dio.dart';
import 'package:leenas_mushrooms/api_services/base_url.dart';
import 'package:leenas_mushrooms/model/call_details_add_model_response.dart';
import 'package:leenas_mushrooms/model/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: baseurl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/auth/loginuser')
  Future<LoginResponse> loginUser(@Body() Map<String, dynamic> body);

  @POST("/calldetails/addCalldetails")
  Future<CallDetailsAddModelResponse> addCallDetails(
      @Body() Map<String, dynamic> body);
}
