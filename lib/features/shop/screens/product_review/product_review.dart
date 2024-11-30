import 'package:biriyani/features/shop/screens/product_review/widgets/rating_bar_indicator.dart';
import 'package:biriyani/features/shop/screens/product_review/widgets/rating_progress_indicator.dart';
import 'package:biriyani/features/shop/screens/product_review/widgets/user_review.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';

class ProductReview extends StatelessWidget {
  const ProductReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reviews & Ratings',
          style: TextStyle(color: ThemeUtils.dynamicTextColor(context)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
              ),
              const SizedBox(height: 16),

              // Rating bar
              const RatingProgressIndicator(),
              const MyRatingBarIndicator(rating: 3.8),
              Text('12,322', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 32),

              // User review list
              const MyUserReviewCard(name: 'Jhon Doe'),
              const SizedBox(height: 20),
              const MyUserReviewCard(name: 'Some One'),
            ],
          ),
        ),
      ),
    );
  }
}
