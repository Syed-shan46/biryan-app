import 'dart:convert';

class Order {
  final String userId;
  final String name;
  final String phone;
  final String address;
  final List<String> productName;
  final List<int> quantity; // Changed to int
  final List<String> category;
  final List<int> itemPrice; // Changed to int
  final List<String> image;
  final int totalAmount; // Changed to int
  final String paymentStatus;
  final String orderStatus;
  final bool delivered;
  final String customerDeviceToken;
  final String latLong;

  Order(
      {required this.userId,
      required this.name,
      required this.phone,
      required this.address,
      required this.productName,
      required this.quantity,
      required this.itemPrice,
      required this.category,
      required this.image,
      required this.totalAmount,
      required this.paymentStatus,
      required this.orderStatus,
      required this.delivered,
      required this.latLong,
      required this.customerDeviceToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'phone': phone,
      'address': address,
      'productName': productName,
      'itemPrice': itemPrice,
      'quantity': quantity,
      'category': category,
      'image': image,
      'totalAmount': totalAmount,
      'paymentStatus': paymentStatus,
      'orderStatus': orderStatus,
      'delivered': delivered,
      'customerDeviceToken': customerDeviceToken,
      'latLong': latLong,
    };
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(Map<String, dynamic> map) {
    return Order(
      userId: map['userId'] as String? ?? '',
      name: map['userName'] as String? ?? '',
      phone: map['phone']?.toString() ?? '', // Convert phone to String
      address: map['address'] as String? ?? '',
      productName: List<String>.from(map['productName'] ?? []),
      itemPrice: List<int>.from(map['itemPrice'] ?? []), // Changed to int
      quantity: List<int>.from(map['quantity'] ?? []),
      category: List<String>.from(map['category'] ?? []),
      image: List<String>.from(map['image'] ?? []),
      totalAmount: map['totalAmount'] is int
          ? map['totalAmount'] as int
          : int.tryParse(map['totalAmount'].toString()) ??
              0, // Handle int and String
      paymentStatus: map['paymentStatus'] as String? ?? 'Pending',
      orderStatus: map['orderStatus'] as String? ?? '',
      customerDeviceToken: map['customerDeviceToken'] as String? ?? '',
      latLong: map['latLong'] as String? ?? '',

      delivered: map['delivered'] == true ||
          map['delivered'] == 'true' ||
          map['delivered'] == 1,
    );
  }
}
