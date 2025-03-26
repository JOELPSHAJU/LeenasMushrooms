// To parse this JSON data, do
//
//     final getMushroomDetailsResponse = getMushroomDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'get_mushroom_details_response.g.dart';

GetMushroomDetailsResponse getMushroomDetailsResponseFromJson(String str) =>
    GetMushroomDetailsResponse.fromJson(json.decode(str));

String getMushroomDetailsResponseToJson(GetMushroomDetailsResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetMushroomDetailsResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "pagination")
  Pagination? pagination;
  @JsonKey(name: "data")
  List<Datum>? data;

  GetMushroomDetailsResponse({
    this.status,
    this.pagination,
    this.data,
  });

  factory GetMushroomDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMushroomDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMushroomDetailsResponseToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "harvest_time")
  String? harvestTime;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "damage")
  int? damage;
  @JsonKey(name: "remarks")
  String? remarks;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;

  Datum({
    this.id,
    this.date,
    this.harvestTime,
    this.quantity,
    this.damage,
    this.remarks,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "pages")
  int? pages;
  @JsonKey(name: "limit")
  int? limit;

  Pagination({
    this.total,
    this.pages,
    this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
