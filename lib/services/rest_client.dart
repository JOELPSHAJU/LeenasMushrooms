import 'package:dio/dio.dart';
import 'package:leenas_mushrooms/api_services/base_url.dart';
import 'package:leenas_mushrooms/controller/local_modals/call_details_get_model.dart';
import 'package:leenas_mushrooms/controller/local_modals/order_details_response_model.dart';
import 'package:leenas_mushrooms/model/call_details_add_model_response.dart';
import 'package:leenas_mushrooms/model/login_response.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/daily_data_screen/add_seed_details/model/add_seed_details_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: baseurl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/auth/loginuser')
  Future<LoginResponse> loginUser(@Body() Map<String, dynamic> body);

  @POST("/calldetails/addCalldetails")
  Future<CallDetailsAddModelResponse> addCallDetails(
      @Body() Map<String, dynamic> body);

  @POST("/orderdetails/addOrderdetails")
  Future<OrderDetailsSucessResponse> addOrderDetails(
      @Body() Map<String, dynamic> body);

  @GET('/calldetails/getCalldetails?page=1&limit=10')
  Future<CallDetailsGetModel> getCallDetails();

  @POST('/seeddetails/addSeeddetails')
  Future<AddSeedDetailsModel> addSeeddetails(@Body() Map<String, dynamic> body);

  // @POST("/mushroomdetails/addMushroomdetails")
  // Future<OrderDetailsResponse> addMushroomHarvestDetails(
  //     @Body() Map<String, dynamic> body);
}
