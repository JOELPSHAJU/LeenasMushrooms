// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_mushroom_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMushroomDetailsResponse _$GetMushroomDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMushroomDetailsResponse(
      status: json['status'] as String?,
      total: (json['total'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMushroomDetailsResponseToJson(
        GetMushroomDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['_id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      harvestTime: json['harvest_time'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      damage: (json['damage'] as num?)?.toInt(),
      remarks: json['remarks'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      '_id': instance.id,
      'date': instance.date?.toIso8601String(),
      'harvest_time': instance.harvestTime,
      'quantity': instance.quantity,
      'damage': instance.damage,
      'remarks': instance.remarks,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
