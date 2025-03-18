class OrderDetailsResponse {
  final String status;
  final OrderData data;

  OrderDetailsResponse({
    required this.status,
    required this.data,
  });

  // Factory method to create a model from JSON
  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      status: json['status'] ?? '',
      data: OrderData.fromJson(json['data'] ?? {}),
    );
  }

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class OrderData {
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
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  OrderData({
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
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  // Factory method to create OrderData from JSON
  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      date: json['date'] ?? '',
      item: json['item'] ?? '',
      orderType: json['order_type'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      pincode: json['pincode'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      catalogue: json['catalogue'] ?? '',
      quantity: json['quantity'] ?? 0,
      courierData: json['courier_data'] ?? '',
      courierProvider: json['courier_provider'] ?? '',
      courierRefNo: json['courier_ref_no'] ?? '',
      trackingId: json['tracking_id'] ?? '',
      trackingStatus: json['tracking_status'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      id: json['_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  // Method to convert OrderData to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'item': item,
      'order_type': orderType,
      'name': name,
      'address': address,
      'pincode': pincode,
      'phone_number': phoneNumber,
      'catalogue': catalogue,
      'quantity': quantity,
      'courier_data': courierData,
      'courier_provider': courierProvider,
      'courier_ref_no': courierRefNo,
      'tracking_id': trackingId,
      'tracking_status': trackingStatus,
      'payment_status': paymentStatus,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
