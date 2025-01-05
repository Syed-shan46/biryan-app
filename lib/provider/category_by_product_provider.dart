import 'dart:convert';

import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:biriyani/features/authentication/models/product.dart';
import 'package:http/http.dart' as http;

class CategoryByProductProvider extends StateNotifier<Map<String, List<Product>>> {
  CategoryByProductProvider() : super({}); // Initializing the state as an empty map

  Future<void> loadProductsByCategory(String categoryId) async {
    // Check if the products for this category are already loaded
    if (state.containsKey(categoryId)) return;

    try {
      final response = await http.get(
        Uri.parse("$uri/api/category/$categoryId"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        state = {...state, categoryId: products}; // Add products to the map
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

// Create a provider for managing products
final categoryByproductProvider =
    StateNotifierProvider<CategoryByProductProvider, Map<String, List<Product>>>((ref) {
  return CategoryByProductProvider();
});
