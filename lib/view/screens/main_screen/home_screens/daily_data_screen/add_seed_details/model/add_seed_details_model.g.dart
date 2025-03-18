// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_seed_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddSeedDetailsModel _$AddSeedDetailsModelFromJson(Map<String, dynamic> json) =>
    AddSeedDetailsModel(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddSeedDetailsModelToJson(
        AddSeedDetailsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      harvestTime: json['harvest_time'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      noOfPackets: (json['no_of_packets'] as num?)?.toInt(),
      remarks: json['remarks'] as String?,
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
      'harvest_time': instance.harvestTime,
      'quantity': instance.quantity,
      'no_of_packets': instance.noOfPackets,
      'remarks': instance.remarks,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
