import 'package:biriyani/features/shop/screens/cart/cart_screen.dart';
import 'package:biriyani/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyCartIcon extends ConsumerStatefulWidget {
  const MyCartIcon({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  _MyCartIconState createState() => _MyCartIconState();
}

class _MyCartIconState extends ConsumerState<MyCartIcon> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    return badges.Badge(
      badgeAnimation: const badges.BadgeAnimation.rotation(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        toAnimate: true,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeStyle: const badges.BadgeStyle(padding: EdgeInsets.all(4)),
      position: badges.BadgePosition.topEnd(top: -12, end: -6),
      badgeContent: Text(
        cartData.length.toString(),
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      child: InkWell(
        onTap: () => Get.to(() => const CartScreen()),
        child: Icon(
          Iconsax.shopping_bag,
          color: widget.color,
        ),
      ),
    );
  }
}
