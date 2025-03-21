// To parse this JSON data, do
//
//     final expenseAdditionResponse = expenseAdditionResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'expense_addition_response.g.dart';

ExpenseAdditionResponse expenseAdditionResponseFromJson(String str) => ExpenseAdditionResponse.fromJson(json.decode(str));

String expenseAdditionResponseToJson(ExpenseAdditionResponse data) => json.encode(data.toJson());

@JsonSerializable()
class ExpenseAdditionResponse {
    @JsonKey(name: "status")
    String? status;
    @JsonKey(name: "data")
    Data? data;

    ExpenseAdditionResponse({
        this.status,
        this.data,
    });

    factory ExpenseAdditionResponse.fromJson(Map<String, dynamic> json) => _$ExpenseAdditionResponseFromJson(json);

    Map<String, dynamic> toJson() => _$ExpenseAdditionResponseToJson(this);
}

@JsonSerializable()
class Data {
    @JsonKey(name: "date")
    DateTime? date;
    @JsonKey(name: "user_details")
    String? userDetails;
    @JsonKey(name: "expense_type")
    String? expenseType;
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
        this.expenseType,
        this.amount,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}
