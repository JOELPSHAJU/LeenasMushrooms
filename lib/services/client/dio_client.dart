import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:leenas_mushrooms/api_services/base_url.dart';
import 'package:leenas_mushrooms/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';


Dio getDioClient() {
  Dio dio = Dio();

  dio.options = BaseOptions(
    receiveTimeout: const Duration(seconds: 50),
    connectTimeout: const Duration(seconds: 50),
    baseUrl: baseurl,
    followRedirects: true,
  );
 
  dio.interceptors.add(TokenInterceptor(dio));
  dio.interceptors.add(
    TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printRequestData: true,
        printResponseHeaders: true,
        printResponseData: true,
        printErrorData: true,
      ),
    ),
  );
  return dio;
}

class TokenInterceptor extends Interceptor {
  final Dio dio;

  TokenInterceptor(this.dio);

  static const String loginEndpoint = '/auth/loginuser';

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.path.contains(loginEndpoint)) {
      final token = await getAccessToken();
      if (token != null) {
        options.headers["Authorization"] = "Bearer $token";
        log("Token added to request: $token");
      } else {
        log("No token available for request: ${options.path}");
      }
    } else {
      log("Login request detected, skipping token addition: ${options.path}");
    }
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 && 
        !err.requestOptions.path.contains(loginEndpoint)) {
      log("401 error received for ${err.requestOptions.path}");
      final existingToken = await getAccessToken();

      if (existingToken == null) {
        log("No token found, user likely needs to log in again");
        await removeAccessToken();
        
        isLoggedIn.value = false;
      } else {
        log("Token exists but still got 401, might be invalid or server issue");
      }
    }
    log("Error ${err.response?.statusCode} for ${err.requestOptions.path}");
    return super.onError(err, handler);
  }
}