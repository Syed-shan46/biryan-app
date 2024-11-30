// ignore_for_file: unused_field

import 'package:biriyani/common/custom_container.dart';
import 'package:biriyani/common/custom_text_field.dart';
import 'package:biriyani/features/shop/screens/search/widgets/loading_widget.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 74.h,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: ThemeUtils.sameBrightness(context),
        title: Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: CustomTextWidget(
            controller: _searchController,
            keyboardType: TextInputType.text,
            hintText: "Search For Foods",
            suffixIcon: GestureDetector(
                onTap: () {},
                child: Icon(Ionicons.search_circle,
                    size: 40.h, color: Colors.grey)),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
            color: ThemeUtils.sameBrightness(context),
            containerContent: const LoadingWidget()),
      ),
    );
  }
}
