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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  //Checking if already address is on Db

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: AppBar(
        title: const Text('Cart'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: MyCartIcon(),
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
            ),

            /// Cart items card
            const Padding(
              padding: EdgeInsets.all(MySizes.spaceBtwItems),
              child: CartItemCard(
                showQuantity: false,
                showButtons: true,
              ),
            ),

            Divider(
                color: Colors.grey.withOpacity(0.3), indent: 20, endIndent: 20),
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
              ),
            )
          ],
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
