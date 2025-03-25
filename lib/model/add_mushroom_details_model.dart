// To parse this JSON data, do
//
//     final addMushroomDetailsModel = addMushroomDetailsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'add_mushroom_details_model.g.dart';

AddMushroomDetailsModel addMushroomDetailsModelFromJson(String str) =>
    AddMushroomDetailsModel.fromJson(json.decode(str));

String addMushroomDetailsModelToJson(AddMushroomDetailsModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AddMushroomDetailsModel {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "data")
  Data? data;

  AddMushroomDetailsModel({
    this.status,
    this.data,
  });

  factory AddMushroomDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AddMushroomDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddMushroomDetailsModelToJson(this);
}

@JsonSerializable()
class Data {
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
    this.damage,
    this.remarks,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
