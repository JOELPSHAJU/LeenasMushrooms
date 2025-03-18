// To parse this JSON data, do
//
//     final addSeedDetailsModel = addSeedDetailsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'add_seed_details_model.g.dart';

AddSeedDetailsModel addSeedDetailsModelFromJson(String str) =>
    AddSeedDetailsModel.fromJson(json.decode(str));

String addSeedDetailsModelToJson(AddSeedDetailsModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AddSeedDetailsModel {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "data")
  Data? data;

  AddSeedDetailsModel({
    this.status,
    this.data,
  });

  factory AddSeedDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AddSeedDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddSeedDetailsModelToJson(this);
}

@JsonSerializable()
class Data {
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
    this.harvestTime,
    this.quantity,
    this.noOfPackets,
    this.remarks,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
