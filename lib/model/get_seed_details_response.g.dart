// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_seed_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSeedDetailsResponse _$GetSeedDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    GetSeedDetailsResponse(
      status: json['status'] as String?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSeedDetailsResponseToJson(
        GetSeedDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'pagination': instance.pagination,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['_id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      harvestTime: json['harvest_time'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      noOfPackets: (json['no_of_packets'] as num?)?.toInt(),
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
      'no_of_packets': instance.noOfPackets,
      'remarks': instance.remarks,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      total: (json['total'] as num?)?.toInt(),
      pages: (json['pages'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'pages': instance.pages,
      'limit': instance.limit,
    };
