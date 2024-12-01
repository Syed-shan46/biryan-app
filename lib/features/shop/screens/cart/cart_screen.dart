import 'package:biriyani/common/cart/cart_icon.dart';
import 'package:biriyani/common/cart/cart_item_card.dart';
import 'package:biriyani/features/authentication/screens/login/login.dart';
import 'package:biriyani/navigation_menu.dart';
import 'package:biriyani/utils/constants/constants.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  //Checking if already address is on Db
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Cart').animate().slideY(
              begin: 10, // Start below the screen
              end: 0, // End at normal position
              curve: Curves.easeInOut,
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 1000),
            ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: const MyCartIcon().animate().slideY(
                  begin: 10, // Start below the screen
                  end: 0, // End at normal position
                  curve: Curves.easeInOut,
                  // ignore: prefer_const_constructors
                  delay: Duration(milliseconds: 500),
                  duration: const Duration(milliseconds: 1000),
                ),
          )
        ],
      ),

      // Checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
            ),
            child: Text(
              'Checkout ₹199',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: ThemeUtils.sameBrightness(context)),
            ),
          ).animate().slideY(
                begin: 10, // Start below the screen
                end: 0, // End at normal position
                curve: Curves.easeInOut,
                delay: const Duration(milliseconds: 1000),
                duration: const Duration(milliseconds: 1000),
              ),
        ),
      ),

      /// Heading and cart items
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Text
            const Padding(
              padding: EdgeInsets.only(left: 30, top: 10),
              child: Text('check and pay items'),
            ).animate().slideY(
                  begin: 4, // Start below the screen
                  end: 0, // End at normal position
                  curve: Curves.easeInOut,
                  delay: const Duration(milliseconds: 800),
                  duration: const Duration(milliseconds: 800),
                ),

            /// Cart items card
            const Padding(
              padding: EdgeInsets.all(MySizes.spaceBtwItems),
              child: CartItemCard(
                showQuantity: false,
                showButtons: true,
              ),
            ).animate().slideY(
                  begin: 1, // Start below the screen
                  end: 0, // End at normal position
                  curve: Curves.easeInOut,
                  delay: Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 800),
                ),

            Divider(
                    color: Colors.grey.withOpacity(0.3),
                    indent: 20,
                    endIndent: 20)
                .animate()
                .slideX(
                  begin: -5, // Start below the screen
                  end: 0, // End at normal position
                  curve: Curves.easeInOut,
                  delay: Duration(milliseconds: 1500),
                  duration: const Duration(milliseconds: 1300),
                ),
            const SizedBox(height: MySizes.spaceBtwItems),

            /// Coupon box

            const SizedBox(height: MySizes.spaceBtwItems),

            /// Price details
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: MySizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('*FREE Delivery available only India'),
                  const SizedBox(height: MySizes.spaceBtwItems),
                  Text(
                    'Price',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),

                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                  ).animate().slideX(
                        begin: -5, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: Duration(milliseconds: 1500),
                        duration: const Duration(milliseconds: 1300),
                      ),
                  const SizedBox(height: MySizes.spaceBtwItems / 2),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('${2} items'),
                      Text(
                        '₹199',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems / 2),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Coupon Offer'),
                      Text(
                        '- \$00.00',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      )
                    ],
                  ),

                  const SizedBox(height: MySizes.spaceBtwItems / 2),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Delivery Fee'),
                      Text(
                        '+ 00.00',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      )
                    ],
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems / 2),

                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                  ).animate().slideX(
                        begin: -5, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: Duration(milliseconds: 1500),
                        duration: const Duration(milliseconds: 1300),
                      ),

                  /// Total Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₹199',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      )
                    ],
                  ),
                ],
              ).animate().slideY(
                    begin: 1, // Start below the screen
                    end: 0, // End at normal position
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 800),
                  ),
            )
          ],
        )
            .animate(
              autoPlay: false,
              controller: _controller,
            )
            .blurXY(
                begin: 0, end: 25, duration: 600.ms, curve: Curves.easeInOut)
            .scaleXY(begin: 1, end: 0.6)
            .fadeOut(
              begin: 1,
            ),
      ),
    );
  }

  Future<dynamic> showVerificationSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 230.h,
          decoration: const BoxDecoration(
              // image: DecorationImage(
              //   colorFilter: ColorFilter.mode(ThemeUtils.sameBrightness(context), BlendMode.dstATop),
              //   image: AssetImage('assets/images/products/bg-3.png'),
              //   fit: BoxFit.contain,
              // ),
              ),
          child: Padding(
            padding: EdgeInsets.all(9.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                const Text(
                  'Verify Your Phone Number',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  child: Column(
                    children: (List.generate(
                      verificationReasons.length,
                      (index) {
                        return ListTile(
                          leading: const Icon(Icons.check_circle_outline,
                              color: AppColors.primaryColor),
                          title: Text(
                            verificationReasons[index],
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.normal),
                          ),
                        );
                      },
                    )),
                  ),
                ),
                const SizedBox(height: MySizes.spaceBtwItems),
                ElevatedButton(
                    onPressed: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: Text('Verify Account',
                        style: TextStyle(
                          color: ThemeUtils.sameBrightness(context),
                        )))
              ],
            ),
          ),
        );
      },
    );
  }
}

class PurchaseBtn extends StatelessWidget {
  const PurchaseBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MySizes.defaultSpace),
      child: Bounce(
        tiltAngle: BorderSide.strokeAlignInside,
        filterQuality: FilterQuality.high,
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => const NavigationMenu());
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
            child: Text(
              'Purchase now',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: ThemeUtils.sameBrightness(context)),
            ),
          ),
        ),
      ),
    );
  }
}

class CouponBox extends StatelessWidget {
  const CouponBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MySizes.defaultSpace),
      child: SizedBox(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'Enter Your Coupon Code',
                  filled: true,
                  fillColor: AppColors.primaryColor.withOpacity(0.1),
                  prefixIcon: Icon(
                    Icons.discount_outlined,
                    color: AppColors.primaryColor.withOpacity(0.5),
                  ),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            )
          ],
        ),
      ),
    );
  }
}
