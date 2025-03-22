// To parse this JSON data, do
//
//     final addBedDetailsModel = addBedDetailsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'add_bed_details_model.g.dart';

AddBedDetailsModel addBedDetailsModelFromJson(String str) =>
    AddBedDetailsModel.fromJson(json.decode(str));

String addBedDetailsModelToJson(AddBedDetailsModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AddBedDetailsModel {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AddBedDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory AddBedDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AddBedDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddBedDetailsModelToJson(this);
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
