import 'package:leenas_mushrooms/controller/local_modals/call_details_add_model.dart';
import 'package:leenas_mushrooms/model/call_details_add_model_response.dart';
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

  Future<CallDetailsAddModelResponse> addCallDetails(
      {required Map<String, dynamic> credentials}) async {
    return await _client.addCallDetails(credentials);
  }
}