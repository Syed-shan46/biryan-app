import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/tab_widget.dart';
import 'package:biriyani/utils/constants/constants.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersTabs extends StatelessWidget {
  const OrdersTabs({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: _tabController,
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: AppColors.primaryColor.withOpacity(0.9)),
        labelColor: Colors.white,
        labelStyle: appStyle(12, Colors.white, FontWeight.normal),
        unselectedLabelColor: AppColors.primaryColor.withOpacity(0.6),
        tabAlignment: TabAlignment.start,
        tabs: List.generate(
            orderList.length, (i) => TabWidget(text: orderList[i])));
  }
}
