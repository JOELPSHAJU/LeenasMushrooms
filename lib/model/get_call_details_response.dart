// To parse this JSON data, do
//
//     final getCallDetailsResponse = getCallDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'get_call_details_response.g.dart';

GetCallDetailsResponse getCallDetailsResponseFromJson(String str) =>
    GetCallDetailsResponse.fromJson(json.decode(str));

String getCallDetailsResponseToJson(GetCallDetailsResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetCallDetailsResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "data")
  List<Datum>? data;
  @JsonKey(name: "pagination")
  Pagination? pagination;

  GetCallDetailsResponse({
    this.status,
    this.data,
    this.pagination,
  });

  factory GetCallDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCallDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCallDetailsResponseToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "call_type")
  String? callType; // Changed from enum to String
  @JsonKey(name: "name")
  String? name; // Changed from enum to String
  @JsonKey(name: "phone_number")
  String? phoneNumber;
  @JsonKey(name: "purpose")
  String? purpose; // Changed from enum to String
  @JsonKey(name: "current_status")
  String? currentStatus; // Changed from enum to String
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;

  Datum({
    this.id,
    this.date,
    this.callType,
    this.name,
    this.phoneNumber,
    this.purpose,
    this.currentStatus,
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

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
