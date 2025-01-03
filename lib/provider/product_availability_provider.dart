import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductAvailabilityNotifier extends StateNotifier<bool> {
  ProductAvailabilityNotifier() : super(true);

  // Fetch product availability from the backend
  Future<void> fetchProductAvailability(String productId) async {
    final url = '$uri/api/product/$productId/availability';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        state = data['isAvailable'];
      } else {
        state = false; // If error occurs, set to false
      }
    } catch (error) {
      state = false; // If network error occurs, set to false
    }
  }
}

final productAvailabilityProvider =
    StateNotifierProvider.family<ProductAvailabilityNotifier, bool, String>(
        (ref, productId) {
  return ProductAvailabilityNotifier();
});
