import 'package:leenas_mushrooms/model/add_bed_details_model.dart';
import 'package:leenas_mushrooms/model/add_mushroom_details_model.dart';
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
import 'package:leenas_mushrooms/services/rest_client.dart';
import 'package:leenas_mushrooms/view/screens/main_screen/home_screens/daily_data_screen/add_seed_details/model/add_seed_details_model.dart';

class DataVerseRepository {
  DataVerseRepository({
    required RestClient client,
  }) : _client = client;
  final RestClient _client;

  Future<LoginResponse> addLoginUser(
      {required Map<String, dynamic> credentials}) async {
    return await _client.loginUser(credentials);
  }

  Future<CallDetailsAddModelResponse> addCallDetailsApi(
      {required Map<String, dynamic> credentials}) async {
    return await _client.addCallDetails(credentials);
  }

  Future<OrderDetailsSucessResponse> addOrderDetailsApi(
      {required Map<String, dynamic> credentials}) async {
    return await _client.addOrderDetails(credentials);
  }

  Future<GetCallDetailsResponse> getCallDetailsApi({required int page}) async {
    return _client.getCallDetails(page, 10);
  Future<GetCallDetailsResponse> getCallDetailsApi({required int page}) async {
    return _client.getCallDetails(page, 10);
  }

  Future<AddSeedDetailsModel> addSeedDetailsApi(
      {required Map<String, dynamic> credentials}) async {
    return await _client.addSeeddetails(credentials);
  }

  Future<IncomeAdditionResponse> addIncomeDetailsApi(
      {required Map<String, dynamic> credentials}) async {
    return await _client.addIncomeDetails(credentials);
  }

  Future<ExpenseAdditionResponse> addExpenseDetailsApi(
      {required Map<String, dynamic> credentials}) async {
    return await _client.addExpenseDetails(credentials);
  }

  Future<GetIncomeDetailsResponse> getIncomeDetailsApi(
      {required int page}) async {
    return _client.getIncomeDetails(page, 10);

  Future<GetIncomeDetailsResponse> getIncomeDetailsApi(
      {required int page}) async {
    return _client.getIncomeDetails(page, 10);
  }

  Future<GetExpenseDetailsResponse> getExpenseDetailsApi(
      {required int page}) async {
    return _client.getExpenseDetails(page, 10);
  }

  Future<GetOrderDetailsResponse> getOrderDetailsApi(
      {required int page}) async {
    return _client.getOrderDetails(page, 10);
  }

  Future<GetMushroomDetailsResponse> getMushroomDetailsApi(
      {required int page}) async {
    return _client.getMushroomDetails(page, 10);
      }
  Future<AddBedDetailsModel> addBedDetailsApi(
      {required Map<String, dynamic> credentials}) async {
    return await _client.addBedeDetails(credentials);
  }

  Future<AddMushroomDetailsModel> addMushroomDetailsApi(
      {required Map<String, dynamic> credentials}) async {
    return await _client.addMushroomeDetails(credentials);
  }
}
