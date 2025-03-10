// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'login_response.g.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

@JsonSerializable()
class LoginResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "token")
    String? token;

    LoginResponse({
        this.message,
        this.token,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

    Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
