// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_details_add_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallDetailsAddModelResponse _$CallDetailsAddModelResponseFromJson(
        Map<String, dynamic> json) =>
    CallDetailsAddModelResponse(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      callType: json['call_type'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      purpose: json['purpose'] as String?,
      currentStatus: json['current_status'] as String?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CallDetailsAddModelResponseToJson(
        CallDetailsAddModelResponse instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'call_type': instance.callType,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'purpose': instance.purpose,
      'current_status': instance.currentStatus,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
