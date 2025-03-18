import 'package:leenas_mushrooms/controller/local_modals/call_details_get_model.dart';
import 'package:leenas_mushrooms/model/order_details_sucess_response.dart';
import 'package:leenas_mushrooms/model/call_details_add_model_response.dart';
import 'package:leenas_mushrooms/model/income_addition_response.dart';
import 'package:leenas_mushrooms/model/login_response.dart';
import 'package:leenas_mushrooms/services/rest_client.dart';

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

  Future<CallDetailsGetModel> getCallDetailsApi() async {
    return _client.getCallDetails();
  }

   Future<IncomeAdditionResponse> addIncomeDetaisApi(
      {required Map<String, dynamic> credentials}) async {
    return await _client.addIncomeDetails(credentials);
  }
}
