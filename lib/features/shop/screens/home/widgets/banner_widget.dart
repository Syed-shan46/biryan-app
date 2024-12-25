import 'package:flutter/material.dart';

class MyBannerWidget extends StatelessWidget {
  const MyBannerWidget({super.key, required this.imageUrl});

  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 9,right: 9,bottom: 9),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(
            
            fit: BoxFit.cover,
            image: AssetImage(imageUrl) as ImageProvider,
          ),
        ),
      ),
    );
  }
}
