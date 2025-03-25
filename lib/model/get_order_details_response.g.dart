// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_order_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrderDetailsResponse _$GetOrderDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    GetOrderDetailsResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetOrderDetailsResponseToJson(
        GetOrderDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'pagination': instance.pagination,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['_id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      orderType: json['order_type'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      pincode: json['pincode'] as String?,
      phoneNumber: json['phone_number'] as String?,
      catalogue: json['catalogue'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      courierData: json['courier_data'] as String?,
      courierProvider: json['courier_provider'] as String?,
      courierRefNo: json['courier_ref_no'] as String?,
      trackingId: json['tracking_id'] as String?,
      trackingStatus: json['tracking_status'] as String?,
      paymentStatus: json['payment_status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
      item: json['item'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      '_id': instance.id,
      'date': instance.date?.toIso8601String(),
      'order_type': instance.orderType,
      'name': instance.name,
      'address': instance.address,
      'pincode': instance.pincode,
      'phone_number': instance.phoneNumber,
      'catalogue': instance.catalogue,
      'quantity': instance.quantity,
      'courier_data': instance.courierData,
      'courier_provider': instance.courierProvider,
      'courier_ref_no': instance.courierRefNo,
      'tracking_id': instance.trackingId,
      'tracking_status': instance.trackingStatus,
      'payment_status': instance.paymentStatus,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'item': instance.item,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'totalCount': instance.totalCount,
      'limit': instance.limit,
    };
