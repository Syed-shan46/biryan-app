import 'dart:convert';
import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/reusable_text.dart';
import 'package:biriyani/features/authentication/screens/login/phone_verification_page.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/utils/constants/constants.dart';
import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class DeliveredScreen extends ConsumerStatefulWidget {
  const DeliveredScreen({super.key});

  @override
  ConsumerState<DeliveredScreen> createState() => _DeliveredScreenState();
}

class _DeliveredScreenState extends ConsumerState<DeliveredScreen> {
  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<List<Map<String, dynamic>>> _fetchOrders() async {
    final user = ref.read(userProvider);
    print(user!.id);
    final String userId = user.id;

    try {
      final response = await http.get(
        Uri.parse('$uri/api/orders/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> data = json.decode(response.body);
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
                 Get.to(() => const PhoneVerificationPage());
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
      future: _fetchOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.hexagonDots(
                color: AppColors.primaryColor, size: 20),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Column(
            children: [
              Lottie.asset(
                'assets/images/no-item.json',
                width: 350,
                height: 350,
                fit: BoxFit.fill,
              ),
              const Center(
                child: Text('No orders found'),
              ),
            ],
          );
        }

        // If the user is not logged in

        final orders = snapshot.data!;
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
                        Text(
                          'Order ID: ${order['_id'] is Map ? order['_id']['\$oid'] : order['_id']}',
                        ),
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
