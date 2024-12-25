import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/reusable_text.dart';
import 'package:biriyani/features/shop/controllers/order_controller.dart';
import 'package:biriyani/features/shop/models/order_model.dart';
import 'package:biriyani/provider/order_provider.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/utils/constants/constants.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';

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
    return orders.isEmpty
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
                    return Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            height: 60.h,
                            width: width,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(9.r)),
                            child: Container(
                              padding: EdgeInsets.all(4.r),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: 60.w,
                                          height: 60.h,
                                          child: Image.network(
                                            order.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        text: order.productName,
                                        style: appStyle(
                                            11, Colors.black, FontWeight.w400),
                                      ),
                                      ReusableText(
                                        text: "Quantity: ${order.quantity}",
                                        style: appStyle(
                                            11, Colors.black, FontWeight.w400),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 8.w,
                          top: 6.h,
                          child: Container(
                            width: 60.w,
                            height: 19.h,
                            decoration: BoxDecoration(
                                color: AppColors.accentColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                              child: ReusableText(
                                  text: "₹${order.totalAmount}",
                                  style: appStyle(
                                      12, Colors.white, FontWeight.bold)),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 75.w,
                          top: 6.h,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 19.w,
                              height: 19.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Center(
                                child: Icon(
                                  MaterialCommunityIcons.cart_plus,
                                  size: 15.h,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
  }
}
