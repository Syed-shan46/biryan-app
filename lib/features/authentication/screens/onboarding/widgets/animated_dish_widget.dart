import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedDishWidget extends StatelessWidget {
  final Duration dishPlayDuration;
  final Duration leavesDelayDuration;
  const AnimatedDishWidget({
    super.key,
    required this.dishPlayDuration,
    required this.leavesDelayDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Lottie.asset(
        'assets/images/delivery.json',
        fit: BoxFit.contain,
        height: 340,
      ),
    );
  }
}
