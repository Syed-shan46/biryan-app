import 'package:biriyani/common/custom_shapes/primary_header_container.dart';
import 'package:biriyani/features/shop/controllers/order_controller.dart';
import 'package:biriyani/features/shop/models/order_model.dart';
import 'package:biriyani/provider/order_provider.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final user = ref.read(userProvider);
    if (user != null) {
      final orderController = OrderController();
      try {
        final orders = await orderController.loadOrders(userId: user.id);
        print('Raw JSON response: $orders');
        print(user.id);
        print(
            'Fetched orders count: ${orders.length}'); // Debug log for orders count
        ref.read(orderProvider.notifier).setOrders(orders);
      } catch (e) {
        print('Error fetching orders: $e');
      }
    } else {
      print('Error: User is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final orders = ref.watch(orderProvider);
    return Scaffold(
      body: orders.isEmpty
          ? Column(
              children: [
                Lottie.network(
                  'https://lottie.host/e5c80fca-fe94-4bed-9424-e0d70204d1aa/lhGyjYqBYY.json',
                  width: 350,
                  height: 350,
                  fit: BoxFit.fill,
                ),
                const Center(
                  child: Text('No orders found'),
                ),
              ],
            )
          : Column(
              children: [
                const SizedBox(height: MySizes.spaceBtwItems),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: MySizes.spaceBtwItems,
                    ),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final Order order = orders[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            
                            Container(
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.grey.withOpacity(0.1)
                                    : DynamicBg.sameBrightness(
                                        context), // Base color for the box
                                boxShadow: isDarkMode
                                    ? [] // No shadow in dark mode
                                    : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                              0.1), // Shadow color for light mode
                                          blurRadius: 50,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                // No border in light mode
                                borderRadius: BorderRadius.circular(
                                    12), // Optional rounded corners
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        // image
                                        Container(
                                            width: 65,
                                            height: 65,
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Image.network(order.image[0])),

                                        const SizedBox(
                                            width: MySizes.spaceBtwItems),

                                        /// title, price, size
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  /// Category
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: isDarkMode
                                                                ? AppColors
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        0.8)
                                                                : AppColors
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 8,
                                                                vertical: 0),
                                                        child: Text(
                                                            order.category[0]),
                                                      )
                                                    ],
                                                  ),

                                                  /// Price
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '₹${order.totalAmount}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),

                                              const SizedBox(height: 2),

                                              /// Product name
                                              Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    order.productName[0],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium,
                                                  )),

                                              const SizedBox(height: 2),

                                              /// Quantity
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                          child: Text(
                                                        order.orderStatus,
                                                        style: TextStyle(
                                                            color: order.orderStatus ==
                                                                    'Processing'
                                                                ? Colors.red
                                                                : Colors.blue),
                                                      ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(order.quantity
                                                          .toString())
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: MySizes.spaceBtwItems / 2),
                                    Text(
                                      'Delivery address',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const SizedBox(height: 3),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 3),
                                        Text(
                                          'To: ${order.name}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text('${order.phone} ${order.address}')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
