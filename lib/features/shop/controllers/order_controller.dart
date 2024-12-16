import 'dart:convert';

import 'package:biriyani/features/shop/models/order_model.dart';
import 'package:biriyani/features/shop/screens/order/success_screen.dart';
import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderController {
  createOrders({
    required final String id,
    required final String name,
    required final String phone,
    required final String address,
    required final String productName,
    required final int quantity,
    required final String category,
    required final String image,
    required final int totalAmount,
    required final String paymentStatus,
    required final String orderStatus,
    required final bool delivered,
    required context,
  }) async {
    try {
      final Order order = Order(
        userId: id,
        phone: phone,
        address: address,
        name: name,
        productName: productName,
        quantity: quantity,
        category: category,
        image: image,
        totalAmount: totalAmount,
        paymentStatus: paymentStatus,
        orderStatus: orderStatus,
        delivered: delivered,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/orders'),
        body: order.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      

      Get.to(() => const SuccessScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<List<Order>> loadOrders({required String userId}) async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/orders/$userId'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((order) => Order.fromJson(order)).toList();
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading orders: $e'); // Logs detailed error
      throw Exception('Error loading orders: $e');
    }
  }
}
