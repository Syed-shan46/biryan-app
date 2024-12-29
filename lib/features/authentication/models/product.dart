import 'dart:convert';

// Defining a class named `Product` that represents a product object with multiple properties.
class Product {
  // Final variables for each product property. `final` means that these variables
  // can only be set once and cannot be changed later.
  final String id; // Unique identifier for the product.
  final String itemName; // Name of the product.
  final int itemPrice; // Price of the product (stored as an integer).
  final int? quantity;
  final bool isAvailable;
  final String description;
  final bool isAdditional; // Detailed description of the product.
  final String category; // Category to which the product belongs.
  final List<String>
      images; // List of image URLs or paths associated with the product.

  // The constructor for the `Product` class. It takes all required parameters
  // to initialize a product object with specific values for each field.
  Product({
    this.quantity,
    required this.isAvailable,
    required this.id, // Assigns the `id` parameter to the `id` property.
    required this.itemName, // Assigns the `productName` parameter to the `productName` property.
    required this.itemPrice, // Assigns the `productPrice` parameter to the `productPrice` property.
    required this.isAdditional, // Assigns the `quantity` parameter to the `quantity` property.
    required this.description, // Assigns the `description` parameter to the `description` property.
    required this.category, // Assigns the `category` parameter to the `category` property.
    required this.images, // Assigns the `images` parameter to the `images` property.
  });

  // Method `toMap` converts the `Product` object into a map (key-value pairs).
  // This is useful when you need to serialize the object to store it in a database or transfer it over a network.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id, // Storing the `id` field in the map with a key of 'id'.
      'quantity': quantity,
      'isAvailable': isAvailable,
      'itemName':
          itemName, // Storing the `productName` field in the map with a key of 'productName'.
      'itemPrice':
          itemPrice, // Storing the `productPrice` field in the map with a key of 'productPrice'.
      'isAdditional':
          isAdditional, // Storing the `quantity` field in the map with a key of 'quantity'.
      'description':
          description, // Storing the `description` field in the map with a key of 'description'.
      'category':
          category, // Storing the `category` field in the map with a key of 'category'.
      'images':
          images, // Storing the `images` list in the map with a key of 'images'.
    };
  }

  // `factory` constructor to create a `Product` object from a map.
  // The map is typically received from an external source like a database or API.
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['_id']
            as String, // Extracts the `id` from the map and assigns it to the `id` field.
        itemName: map['itemName']
            as String, // Extracts the `productName` from the map and assigns it.
        itemPrice: map['itemPrice']
            as int, // Extracts the `productPrice` from the map and assigns it.
        quantity: map['quantity'] as int,
        isAvailable: map['isAvailable'] as bool,
        description: map['description']
            as String, // Extracts the `description` from the map and assigns it.
        category: map['category']
            as String, // Extracts the `category` from the map and assigns it.
        isAdditional: map['isAdditional'] as bool,
        // The `images` field is extracted as a list from the map. The `List<String>.from` method ensures
        // that the list is properly cast to a list of strings.
        images: List<String>.from(
          map['images'].map((item) => item.toString()),
        ));
  }

  // Method `toJson` converts the `Product` object to a JSON string by first calling `toMap`
  // and then encoding the resulting map to JSON using `json.encode`.
  String toJson() => json.encode(toMap());

  // `factory` constructor to create a `Product` object from a JSON string.
  // It first decodes the JSON string into a map using `json.decode`, then
  // passes that map to the `fromMap` constructor to create the `Product`.
  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
