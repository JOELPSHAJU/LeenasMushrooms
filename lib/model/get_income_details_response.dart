// To parse this JSON data, do
//
//     final getIncomeDetailsResponse = getIncomeDetailsResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_income_details_response.g.dart';

GetIncomeDetailsResponse getIncomeDetailsResponseFromJson(String str) => GetIncomeDetailsResponse.fromJson(json.decode(str));

String getIncomeDetailsResponseToJson(GetIncomeDetailsResponse data) => json.encode(data.toJson());

@JsonSerializable()
class GetIncomeDetailsResponse {
    @JsonKey(name: "status")
    String? status;
    @JsonKey(name: "data")
    List<Datum>? data;
    @JsonKey(name: "pagination")
    Pagination? pagination;

    GetIncomeDetailsResponse({
        this.status,
        this.data,
        this.pagination,
    });

    factory GetIncomeDetailsResponse.fromJson(Map<String, dynamic> json) => _$GetIncomeDetailsResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GetIncomeDetailsResponseToJson(this);
}

@JsonSerializable()
class Datum {
    @JsonKey(name: "_id")
    String? id;
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
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "__v")
    int? v;

    Datum({
        this.id,
        this.date,
        this.userDetails,
        this.source,
        this.incomeType,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.v,
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
