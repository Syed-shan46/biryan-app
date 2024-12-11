import 'package:flutter/material.dart';

/// A widget to disable all animations except for specified conditions.
class NoTransitionAnimation extends StatelessWidget {
  final Widget child;
  final bool enableFadeOnReverse; // Allows enabling FadeTransition for reverse

  const NoTransitionAnimation({
    super.key,
    required this.child,
    this.enableFadeOnReverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ModalRoute.of(context)?.animation ?? kAlwaysDismissedAnimation,
      builder: (context, _) {
        final animation = ModalRoute.of(context)?.animation;

        if (animation == null) return child;

        // Apply fade effect only for reverse animation if enabled.
        if (enableFadeOnReverse &&
            animation.status == AnimationStatus.reverse) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }

        // Otherwise, return the child without animation.
        return child;
      },
    );
  }
}
