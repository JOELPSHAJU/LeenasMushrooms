// To parse this JSON data, do
//
//     final getOrderDetailsResponse = getOrderDetailsResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_order_details_response.g.dart';

GetOrderDetailsResponse getOrderDetailsResponseFromJson(String str) => GetOrderDetailsResponse.fromJson(json.decode(str));

String getOrderDetailsResponseToJson(GetOrderDetailsResponse data) => json.encode(data.toJson());

@JsonSerializable()
class GetOrderDetailsResponse {
    @JsonKey(name: "status")
    String? status;
    @JsonKey(name: "data")
    List<Datum>? data;
    @JsonKey(name: "pagination")
    Pagination? pagination;

    GetOrderDetailsResponse({
        this.status,
        this.data,
        this.pagination,
    });

    factory GetOrderDetailsResponse.fromJson(Map<String, dynamic> json) => _$GetOrderDetailsResponseFromJson(json);

    Map<String, dynamic> toJson() => _$GetOrderDetailsResponseToJson(this);
}

@JsonSerializable()
class Datum {
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "date")
    DateTime? date;
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
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "__v")
    int? v;
    @JsonKey(name: "item")
    String? item;

    Datum({
        this.id,
        this.date,
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
        this.createdAt,
        this.updatedAt,
        this.v,
        this.item,
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
