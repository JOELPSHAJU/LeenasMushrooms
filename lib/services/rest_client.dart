import 'package:dio/dio.dart';
import 'package:leenas_mushrooms/api_services/base_url.dart';
import 'package:leenas_mushrooms/model/call_details_add_model_response.dart';
import 'package:leenas_mushrooms/model/expense_addition_response.dart';
import 'package:leenas_mushrooms/model/get_call_details_response.dart';
import 'package:leenas_mushrooms/model/get_expense_details_response.dart';
import 'package:leenas_mushrooms/model/get_income_details_response.dart';
import 'package:leenas_mushrooms/model/get_mushroom_details_response.dart';
import 'package:leenas_mushrooms/model/get_order_details_response.dart';
import 'package:leenas_mushrooms/model/income_addition_response.dart';
import 'package:leenas_mushrooms/model/login_response.dart';
import 'package:leenas_mushrooms/model/order_details_sucess_response.dart';
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

  @GET('/calldetails/getCalldetails')
  Future<GetCallDetailsResponse> getCallDetails(
    @Query("page") int page,
    @Query("limit") int limit,
  );

  @POST("/incomedetails/addIncomedetails")
  Future<IncomeAdditionResponse> addIncomeDetails(
      @Body() Map<String, dynamic> body);

  @POST('/seeddetails/addSeeddetails')
  Future<AddSeedDetailsModel> addSeeddetails(@Body() Map<String, dynamic> body);

  @POST('/expensedetails/addExpensedetails')
  Future<ExpenseAdditionResponse> addExpenseDetails(
      @Body() Map<String, dynamic> body);

  @GET('/incomedetails/getiIncomedetails')
  Future<GetIncomeDetailsResponse> getIncomeDetails(
    @Query("page") int page,
    @Query("limit") int limit,
  );
  @GET('/expensedetails/getExpensedetails')
  Future<GetExpenseDetailsResponse> getExpenseDetails(
    @Query("page") int page,
    @Query("limit") int limit,
  );

  @GET('/orderdetails/getOrderdetails')
  Future<GetOrderDetailsResponse> getOrderDetails(
    @Query("page") int page,
    @Query("limit") int limit,
  );
   @GET('/mushroomdetails/getMushroomdetails')
  Future<GetMushroomDetailsResponse> getMushroomDetails(
    @Query("page") int page,
    @Query("limit") int limit,
  );
}
