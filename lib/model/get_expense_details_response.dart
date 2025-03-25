// To parse this JSON data, do
//
//     final getExpenseDetailsResponse = getExpenseDetailsResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_expense_details_response.g.dart';

GetExpenseDetailsResponse getExpenseDetailsResponseFromJson(String str) => GetExpenseDetailsResponse.fromJson(json.decode(str));

String getExpenseDetailsResponseToJson(GetExpenseDetailsResponse data) => json.encode(data.toJson());

@JsonSerializable()
class GetExpenseDetailsResponse {
    @JsonKey(name: "status")
    String? status;
    @JsonKey(name: "data")
    List<Datum>? data;
    @JsonKey(name: "pagination")
    Pagination? pagination;

    GetExpenseDetailsResponse({
        this.status,
        this.data,
        this.pagination,
    });

    factory GetExpenseDetailsResponse.fromJson(Map<String, dynamic> json) => _$GetExpenseDetailsResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GetExpenseDetailsResponseToJson(this);
}

@JsonSerializable()
class Datum {
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "date")
    DateTime? date;
    @JsonKey(name: "expense_type")
    String? expenseType;
    @JsonKey(name: "amount")
    int? amount;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "__v")
    int? v;
    @JsonKey(name: "user_details")
    String? userDetails;

    Datum({
        this.id,
        this.date,
        this.expenseType,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.userDetails,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

    Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Pagination {
    @JsonKey(name: "currentPage")
    int? currentPage;
    @JsonKey(name: "totalPages")
    int? totalPages;
    @JsonKey(name: "totalCount")
    int? totalCount;
    @JsonKey(name: "limit")
    int? limit;

    Pagination({
        this.currentPage,
        this.totalPages,
        this.totalCount,
        this.limit,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

    Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
