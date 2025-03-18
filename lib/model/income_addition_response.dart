// To parse this JSON data, do
//
//     final incomeAdditionResponse = incomeAdditionResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'income_addition_response.g.dart';

IncomeAdditionResponse incomeAdditionResponseFromJson(String str) => IncomeAdditionResponse.fromJson(json.decode(str));

String incomeAdditionResponseToJson(IncomeAdditionResponse data) => json.encode(data.toJson());

@JsonSerializable()
class IncomeAdditionResponse {
    @JsonKey(name: "status")
    String? status;
    @JsonKey(name: "data")
    Data? data;

    IncomeAdditionResponse({
        this.status,
        this.data,
    });

    factory IncomeAdditionResponse.fromJson(Map<String, dynamic> json) => _$IncomeAdditionResponseFromJson(json);

    Map<String, dynamic> toJson() => _$IncomeAdditionResponseToJson(this);
}

@JsonSerializable()
class Data {
    @JsonKey(name: "date")
    DateTime? date;
    @JsonKey(name: "user_details")
    String? userDetails;
    @JsonKey(name: "source")
    String? source;
    @JsonKey(name: "income_type")
    String? incomeType;
    @JsonKey(name: "amount")
    int? amount;
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "__v")
    int? v;

    Data({
        this.date,
        this.userDetails,
        this.source,
        this.incomeType,
        this.amount,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}
