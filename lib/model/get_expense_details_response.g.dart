// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_expense_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetExpenseDetailsResponse _$GetExpenseDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    GetExpenseDetailsResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetExpenseDetailsResponseToJson(
        GetExpenseDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'pagination': instance.pagination,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['_id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      expenseType: json['expense_type'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
      userDetails: json['user_details'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      '_id': instance.id,
      'date': instance.date?.toIso8601String(),
      'expense_type': instance.expenseType,
      'amount': instance.amount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'user_details': instance.userDetails,
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
