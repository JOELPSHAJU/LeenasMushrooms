class OrderDetailsDisplayModel {
  final String id;
  final String date;
  final String item;
  final String orderType;
  final String name;
  final String address;
  final String pincode;
  final String phoneNumber;
  final String catalogue;
  final int quantity;
  final String courierData;
  final String courierProvider;
  final String courierRefNo;
  final String trackingId;
  final String trackingStatus;
  final String paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  OrderDetailsDisplayModel({
    required this.id,
    required this.date,
    required this.item,
    required this.orderType,
    required this.name,
    required this.address,
    required this.pincode,
    required this.phoneNumber,
    required this.catalogue,
    required this.quantity,
    required this.courierData,
    required this.courierProvider,
    required this.courierRefNo,
    required this.trackingId,
    required this.trackingStatus,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}