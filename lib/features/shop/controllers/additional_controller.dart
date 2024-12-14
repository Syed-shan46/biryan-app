import 'dart:convert';
import 'package:biriyani/features/shop/models/additional_model.dart';
import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:http/http.dart' as http;

class ItemController {
  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse('$uri/api/get-additional'));

    if (response.statusCode == 200) {
      // Decode the response as a list of dynamic
      List<dynamic> data = json.decode(response.body);
      print('Response body: ${response.body}');
      // Map the list to a list of Item objects
      return data.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}
