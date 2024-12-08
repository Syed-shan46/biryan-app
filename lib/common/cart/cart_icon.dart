import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:iconsax/iconsax.dart';

class MyCartIcon extends StatefulWidget {
  const MyCartIcon({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  // ignore: library_private_types_in_public_api
  _MyCartIconState createState() => _MyCartIconState();
}

class _MyCartIconState extends State<MyCartIcon> {
  @override
  Widget build(BuildContext context) {
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
      // ignore: prefer_const_constructors
      badgeContent:
          const Text('2', style: TextStyle(fontSize: 12, color: Colors.white)),
      child: InkWell(
        onTap: (){},
        child: Icon(
          Iconsax.shopping_bag,
          color: widget.color,
        ),
      ),
    );
  }
}
