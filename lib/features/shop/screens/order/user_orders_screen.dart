import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/back_ground_container.dart';
import 'package:biriyani/common/reusable_text.dart';
import 'package:biriyani/features/shop/screens/order/cancelled.dart';
import 'package:biriyani/features/shop/screens/order/delivered.dart';
import 'package:biriyani/features/shop/screens/order/delivering.dart';
import 'package:biriyani/features/shop/screens/order/pending.dart';
import 'package:biriyani/features/shop/screens/order/preparing.dart';
import 'package:biriyani/features/shop/screens/order/widgets/orders_tabs.dart';
import 'package:biriyani/utils/constants/constants.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({super.key});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: orderList.length, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeUtils.sameBrightness(context),
        elevation: 0,
        title: ReusableText(
            text: "My Orders",
            style: appStyle(14, AppColors.accentColor, FontWeight.w600)),
      ),
      body: BackGroundContainer(
        color: ThemeUtils.sameBrightness(context),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            OrdersTabs(tabController: _tabController),
            SizedBox(height: 10.h),
            SizedBox(
              height: height * 0.7,
              width: width,
              child: TabBarView(controller: _tabController, children: const [
                DeliveredScreen(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
