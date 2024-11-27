import 'package:biriyani/features/shop/screens/home/widgets/category_list.dart';
import 'package:biriyani/features/shop/screens/home/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyHeader(),
              CategoryList(),
            ],
          ),
        ),
      ),
    );
  }
}
