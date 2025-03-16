import 'dart:convert';

class CallDetailsGetModel {
  final String id;
  final DateTime date;
  final String callType;
  final String name;
  final String phoneNumber;
  final String purpose;
  final String currentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  CallDetailsGetModel({
    required this.id,
    required this.date,
    required this.callType,
    required this.name,
    required this.phoneNumber,
    required this.purpose,
    required this.currentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });


  factory CallDetailsGetModel.fromJson(Map<String, dynamic> json) {
    return CallDetailsGetModel(
      id: json["_id"],
      date: DateTime.parse(json["date"]),
      callType: json["call_type"],
      name: json["name"],
      phoneNumber: json["phone_number"],
      purpose: json["purpose"],
      currentStatus: json["current_status"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
    );
  }

 
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "date": date.toIso8601String(),
      "call_type": callType,
      "name": name,
      "phone_number": phoneNumber,
      "purpose": purpose,
      "current_status": currentStatus,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "__v": v,
    };
  }
}
