import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/back_ground_container.dart';
import 'package:biriyani/common/reusable_text.dart';
import 'package:biriyani/features/shop/screens/order/delivered.dart';
import 'package:biriyani/utils/constants/constants.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({super.key});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> with TickerProviderStateMixin {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeUtils.sameBrightness(context),
        elevation: 0,
        title: ReusableText(
            text: "My Orders",
            style: appStyle(16, ThemeUtils.dynamicTextColor(context), FontWeight.w600)),
      ),
      body: BackGroundContainer(
        color: ThemeUtils.sameBrightness(context),
        child: Column(
          children: [
          
            
            SizedBox(
              height: height * 0.7,
              width: width,
              child: const DeliveredScreen(),
            )
          ],
        ),
      ),
    );
  }
}
