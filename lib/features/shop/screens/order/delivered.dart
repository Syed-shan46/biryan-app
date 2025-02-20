import 'dart:convert';
import 'package:biriyani/features/authentication/screens/login/phone_verification_page.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

class DeliveredScreen extends ConsumerStatefulWidget {
  const DeliveredScreen({super.key});

  @override
  ConsumerState<DeliveredScreen> createState() => _DeliveredScreenState();
}

class _DeliveredScreenState extends ConsumerState<DeliveredScreen> {
  late Future<List<Map<String, dynamic>>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _fetchOrders();
  }

  Future<List<Map<String, dynamic>>> _fetchOrders() async {
    final user = ref.read(userProvider);
    print(user!.userName);

    final String userId = user.id;

    try {
      final response = await http.get(
        Uri.parse('$uri/api/orders/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isEmpty) {
          print('No orders found for user.');
        }
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print('Error fetching orders: $e');
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    if (user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You are not logged in',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const PhoneUserNameScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _ordersFuture, // Use the cached future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.hexagonDots(
                color: AppColors.primaryColor, size: 20),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No orders found'),
          );
        }

        final orders = snapshot.data!;

        // Display orders
        return Column(
          children: [
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16.0,
                ),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final products = (order['products'] as List<dynamic>? ?? []);

                  // Safe retrieval of Order ID
                  final orderId = order['_id'] is Map
                      ? order['_id']['\$oid']
                      : order['_id'].toString();

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order ID: $orderId'),
                        Text('Phone: ${order['phone']}'),
                        Text('Total Amount: ₹${order['totalAmount']}'),
                        Text('Order Status: ${order['orderStatus']}'),
                        const SizedBox(height: 10),
                        const Text('Items:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        ...products.map((product) {
                          return Text(
                              '- ${product['productName']} (x${product['quantity']})');
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
