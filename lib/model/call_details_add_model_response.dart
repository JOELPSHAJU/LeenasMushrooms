// To parse this JSON data, do
//
//     final callDetailsAddModelResponse = callDetailsAddModelResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'call_details_add_model_response.g.dart';

CallDetailsAddModelResponse callDetailsAddModelResponseFromJson(String str) => CallDetailsAddModelResponse.fromJson(json.decode(str));

String callDetailsAddModelResponseToJson(CallDetailsAddModelResponse data) => json.encode(data.toJson());

@JsonSerializable()
class CallDetailsAddModelResponse {
    @JsonKey(name: "date")
    DateTime? date;
    @JsonKey(name: "call_type")
    String? callType;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "phone_number")
    String? phoneNumber;
    @JsonKey(name: "purpose")
    String? purpose;
    @JsonKey(name: "current_status")
    String? currentStatus;
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "__v")
    int? v;

    CallDetailsAddModelResponse({
        this.date,
        this.callType,
        this.name,
        this.phoneNumber,
        this.purpose,
        this.currentStatus,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory CallDetailsAddModelResponse.fromJson(Map<String, dynamic> json) => _$CallDetailsAddModelResponseFromJson(json);

    Map<String, dynamic> toJson() => _$CallDetailsAddModelResponseToJson(this);
}
