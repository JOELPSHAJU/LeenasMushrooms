// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsSucessResponse _$OrderDetailsSucessResponseFromJson(
        Map<String, dynamic> json) =>
    OrderDetailsSucessResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailsSucessResponseToJson(
        OrderDetailsSucessResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      item: json['item'] as String?,
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
      id: json['_id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'item': instance.item,
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
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
