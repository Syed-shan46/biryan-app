import 'dart:convert';
import 'package:biriyani/features/authentication/models/product.dart';
import 'package:biriyani/utils/constants/global_variables.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<Product>> loadProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();

        return products;
      } else {
        throw Exception('Failed to Load Products');
      }
    } catch (e) {
      throw Exception('Error loading Products $e');
    }
  }

  // Fetch Product by ID
  Future<Product> fetchProduct(String id) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products/$id'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Failed , Error: $e');
    }
  }
}
