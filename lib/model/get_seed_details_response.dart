// To parse this JSON data, do
//
//     final getSeedDetailsResponse = getSeedDetailsResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_seed_details_response.g.dart';

GetSeedDetailsResponse getSeedDetailsResponseFromJson(String str) => GetSeedDetailsResponse.fromJson(json.decode(str));

String getSeedDetailsResponseToJson(GetSeedDetailsResponse data) => json.encode(data.toJson());

@JsonSerializable()
class GetSeedDetailsResponse {
    @JsonKey(name: "status")
    String? status;
    @JsonKey(name: "pagination")
    Pagination? pagination;
    @JsonKey(name: "data")
    List<Datum>? data;

    GetSeedDetailsResponse({
        this.status,
        this.pagination,
        this.data,
    });

    factory GetSeedDetailsResponse.fromJson(Map<String, dynamic> json) => _$GetSeedDetailsResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GetSeedDetailsResponseToJson(this);
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
    @JsonKey(name: "no_of_packets")
    int? noOfPackets;
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
        this.noOfPackets,
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

    factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

    Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
