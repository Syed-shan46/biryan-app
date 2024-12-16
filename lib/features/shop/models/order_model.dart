// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Order {
  final String userId;
  final String name;
  final String phone;
  final String address;
  final String productName;
  final int quantity;
  final String category;
  final String image;
  final int totalAmount;
  final String paymentStatus;
  final String orderStatus;
  final bool delivered;
  Order({
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.productName,
    required this.quantity,
    required this.category,
    required this.image,
    required this.totalAmount,
    required this.paymentStatus,
    required this.delivered,
    required this.orderStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'phone': phone,
      
      'address': address,
      'productName': productName,
      'quantity': quantity,
      'category': category,
      'image': image,
      'totalAmount': totalAmount,
      'paymentStatus': paymentStatus,
      'delivered': delivered, 
      'orderStatus': orderStatus,
    };
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(Map<String, dynamic> map) {
    return Order(
      userId: map['userId'] as String? ?? '', // Default to empty string if null
      name: map['name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      address: map['address'] as String? ?? '',
      productName: map['productName'] as String? ?? '',
      quantity: (map['quantity'] is int)
          ? map['quantity'] as int
          : int.tryParse(map['quantity'] as String) ?? 0,
      category: map['category'] as String? ?? '',
      image: map['image'] as String? ?? '',
      totalAmount: (map['totalAmount'] is int)
          ? map['totalAmount'] as int
          : int.tryParse(map['totalAmount'] as String) ?? 0,
      paymentStatus: map['paymentStatus'] as String? ?? 'Pending',
      orderStatus: map['orderStatus'] as String,
      delivered: map['delivered'] as bool? ?? false,
    );
  }
}
