import 'dart:convert';
import 'package:biriyani/features/shop/models/banner_model.dart';
import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:http/http.dart' as http;

class BannerController {
  // Fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();

        return banners;
      } else {
        throw Exception('Failed to Load banners');
      }
    } catch (e) {
      throw Exception('Error loading Banners $e');
    }
  }
}
