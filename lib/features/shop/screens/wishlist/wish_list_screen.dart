import 'package:biriyani/common/back_ground_container.dart';
import 'package:biriyani/common/cart/cart_icon.dart';
import 'package:biriyani/provider/wishlist_provider.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/helpers/box_decoration_helper.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class WishListScreen extends ConsumerStatefulWidget {
  const WishListScreen({super.key});

  @override
  ConsumerState<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends ConsumerState<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final wishItemData = ref.watch(favoriteProvider);
    final wishlistProvider = ref.read(favoriteProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style: TextStyle(
              color: ThemeUtils.dynamicTextColor(context),
              fontWeight: FontWeight.w500),
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.only(right: MySizes.spaceBtwItems),
              child: MyCartIcon())
        ],
      ),
      body: wishItemData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    'https://lottie.host/ed1474e2-1435-47b2-81f5-b0074cb72b13/XdQQTi3uQE.json',
                    width: 350,
                    height: 350,
                    fit: BoxFit.fill,
                  ),
                  const Text('Your wishlist is Empty'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: wishItemData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final wishData = wishItemData.values.toList()[index];
                double screenHeight = MediaQuery.of(context).size.height;
                double screenWidth = MediaQuery.of(context).size.width;
                double itemHeight = screenHeight * 0.13;
                double imageSize = itemHeight * 0.8;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: SizedBox(
                    width: screenWidth,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: imageSize,
                              width: imageSize,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  width: 40.w,
                                  height: 50.w,
                                  wishData.image[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      wishData.itemName,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      child: InkWell(
                                          onTap: () {
                                            wishlistProvider.removeFavItem(
                                                wishData.productId);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: ThemeUtils.dynamicTextColor(
                                                    context)
                                                .withOpacity(0.9),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'delivery in 30 mins',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '₹ ${wishData.itemPrice.toString()}',
                                      style: TextStyle(
                                          color: AppColors.accentColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Cart',
                                        style: TextStyle(
                                            color: ThemeUtils.sameBrightness(
                                                context)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
