// To parse this JSON data, do
//
//     final orderDetailsSucessResponse = orderDetailsSucessResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'order_details_response_model.g.dart';

OrderDetailsSucessResponse orderDetailsSucessResponseFromJson(String str) =>
    OrderDetailsSucessResponse.fromJson(json.decode(str));

String orderDetailsSucessResponseToJson(OrderDetailsSucessResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class OrderDetailsSucessResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "data")
  Data? data;

  OrderDetailsSucessResponse({
    this.status,
    this.data,
  });

  factory OrderDetailsSucessResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsSucessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsSucessResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "item")
  String? item;
  @JsonKey(name: "order_type")
  String? orderType;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "pincode")
  String? pincode;
  @JsonKey(name: "phone_number")
  String? phoneNumber;
  @JsonKey(name: "catalogue")
  String? catalogue;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "courier_data")
  String? courierData;
  @JsonKey(name: "courier_provider")
  String? courierProvider;
  @JsonKey(name: "courier_ref_no")
  String? courierRefNo;
  @JsonKey(name: "tracking_id")
  String? trackingId;
  @JsonKey(name: "tracking_status")
  String? trackingStatus;
  @JsonKey(name: "payment_status")
  String? paymentStatus;
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
    this.item,
    this.orderType,
    this.name,
    this.address,
    this.pincode,
    this.phoneNumber,
    this.catalogue,
    this.quantity,
    this.courierData,
    this.courierProvider,
    this.courierRefNo,
    this.trackingId,
    this.trackingStatus,
    this.paymentStatus,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
