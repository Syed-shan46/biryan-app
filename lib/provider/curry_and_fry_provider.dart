import 'dart:convert';
import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:biriyani/features/authentication/models/product.dart';
import 'package:http/http.dart' as http;

class CurryAndFryProvider extends StateNotifier<List<Product>> {
  CurryAndFryProvider() : super([]); // Initializing the state as an empty list

  // Fetch products for both Rice and Fry categories using the combined API endpoint
  Future<void> loadCurryAndFryProducts() async {
    try {
      final response = await http.get(
        Uri.parse("$uri/api/curry-and-fry-products"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        state = products; // Set the state with the fetched products
      } else {
        throw Exception('Failed to load Curry and Fry products');
      }
    } catch (e) {
      throw Exception('Error fetching Curry and Fry products: $e');
    }
  }
}

// Create a provider for managing Curry and Fry products
final curryAndFryProvider =
    StateNotifierProvider<CurryAndFryProvider, List<Product>>((ref) {
  return CurryAndFryProvider();
});
