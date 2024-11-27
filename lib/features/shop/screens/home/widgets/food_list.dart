import 'package:biriyani/features/shop/screens/home/widgets/food_widget.dart';
import 'package:biriyani/utils/constants/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodList extends StatelessWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.h,
      padding: EdgeInsets.only(left: 12.w),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(foods.length, (i) {
          var food = foods[i];
          return FoodWidget(
              image: food['imageUrl'].toString(),
              title: food['title'],
              price: food['price'].toStringAsFixed(2),
              time: food['time'],);
        }),
      ),
    );
  }
}
