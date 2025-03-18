// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_addition_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeAdditionResponse _$IncomeAdditionResponseFromJson(
        Map<String, dynamic> json) =>
    IncomeAdditionResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IncomeAdditionResponseToJson(
        IncomeAdditionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      userDetails: json['user_details'] as String?,
      source: json['source'] as String?,
      incomeType: json['income_type'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
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
      'user_details': instance.userDetails,
      'source': instance.source,
      'income_type': instance.incomeType,
      'amount': instance.amount,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
