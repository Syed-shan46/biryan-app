import 'package:biriyani/features/shop/screens/home/widgets/food_widget.dart';
import 'package:biriyani/utils/constants/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodList extends StatelessWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 11.w),
        scrollDirection: Axis.horizontal,
        itemCount: foods.length,
        clipBehavior: Clip.none,
        itemBuilder: (context, i) {
          var food = foods[i];
          return FoodWidget(
            image: food['imageUrl'].toString(),
            title: food['title'],
            price: food['price'].toStringAsFixed(2),
            time: food['time'],
          );
        },
      ),
    );
  }
}
