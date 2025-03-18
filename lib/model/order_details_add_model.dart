class OrderDetailsAddModel {
  final String date;

  final String orderType;
  final String name;
  final String address;
  final String pincode;
  final String phoneNumber;
  final String catalogue;
  final String quantity;
  final String courierData;
  final String courierProvider;
  final String courierRefNo;

  final String trackingStatus;
 

  OrderDetailsAddModel({
    required this.date,
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
    required this.trackingStatus,

  });
}
