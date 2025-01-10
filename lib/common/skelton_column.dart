import 'package:biriyani/common/rice_column.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeltonColumn extends StatelessWidget {
  const SkeltonColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                      child: const Skelton(
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: MySizes.spaceBtwItems),
                    const Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Skelton(),
                        ),
                        SizedBox(
                          width: MySizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          flex: 1,
                          child: Skelton(),
                        ),
                      ],
                    ),
                    const SizedBox(height: MySizes.spaceBtwItems),
                    const Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Skelton(),
                        ),
                        SizedBox(
                          width: MySizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          flex: 1,
                          child: Skelton(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                      child: const Skelton(
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: MySizes.spaceBtwItems,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Skelton(),
                        ),
                        SizedBox(
                          width: MySizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          flex: 1,
                          child: Skelton(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: MySizes.spaceBtwItems,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Skelton(),
                        ),
                        SizedBox(
                          width: MySizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          flex: 1,
                          child: Skelton(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}