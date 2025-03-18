import 'package:leenas_mushrooms/controller/local_modals/call_details_get_model.dart';
import 'package:leenas_mushrooms/controller/local_modals/order_details_response_model.dart';
import 'package:leenas_mushrooms/model/call_details_add_model_response.dart';
import 'package:leenas_mushrooms/model/login_response.dart';
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

  Future<CallDetailsGetModel> getCallDetailsApi() async {
    return _client.getCallDetails();
  }

  // Future<CallDetailsGetModel> addSeedDetailsApi() async {
  //   return _client.addSeeddetails();
  // }

  Future<AddSeedDetailsModel> addSeedDetailsApi(
      {required Map<String, dynamic> credentials}) async {
    return await _client.addSeeddetails(credentials);
  }

  // Future<OrderDetailsResponse> addMushroomDetailsApi(
  //     {required Map<String, dynamic> credentials}) async {
  //   return await _client.addMushroomHarvestDetails(credentials);
  // }
}
