import 'package:biriyani/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class MySocialIcons extends StatefulWidget {
  const MySocialIcons({super.key});

  @override
  State<MySocialIcons> createState() => _MySocialIconsState();
}

class _MySocialIconsState extends State<MySocialIcons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
                width: MySizes.iconMd,
                height: MySizes.iconMd,
                image: AssetImage('assets/icons/google-icon.png')),
                
          ),
        ),
        const SizedBox(width: MySizes.spaceBtwItems),

        // facebook
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
                width: MySizes.iconMd,
                height: MySizes.iconMd,
                image: AssetImage('assets/icons/facebook-icon.png')),
          ),
        ),
      ],
    );
  }
}
