import 'package:biriyani/navigation_menu.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/text_theme.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Order Successfully',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              Lottie.network(
                'https://lottie.host/7468eb62-5726-4522-acad-799587cb5a84/CAPyRQ8Ux2.json',
                width: 105.h,
                height: 105.h,
                repeat: false,
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MySizes.spaceBtwSections),
                child: Text(
                  'Thank you for your order! Our team is preparing your delicious meal, and it will be delivered fresh to your doorstep.',
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Shrink to fit the content
          children: [
          
            const SizedBox(height: 2), // Spacing between buttons
            InkWell(
              onTap: () => Get.to(()=> const NavigationMenu()),
              child: Container(
                color: isDarkMode? Colors.grey.withOpacity(0.2): Colors.grey.withOpacity(0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children:  [ 
                    const Padding(
                      padding: EdgeInsets.only(left: MySizes.spaceBtwItems),
                      child: Text('CONTINUE SHOPPING'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: MySizes.spaceBtwItems),
                      child: IconButton(onPressed: (){}, icon:  Icon(CupertinoIcons.arrow_right,color: ThemeUtils.dynamicTextColor(context),),iconSize: 20,),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
