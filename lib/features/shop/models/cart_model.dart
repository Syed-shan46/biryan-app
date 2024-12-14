import 'package:biriyani/features/shop/models/additional_model.dart';

class Cart {
  final String itemName;
  final int itemPrice;
  final String category;
  final List<String> image;
  int quantity;
  final String itemId;
  final List<Item> additionalItems;

  Cart(
      {required this.itemName,
      required this.itemPrice,
      required this.category,
      required this.image,
      required this.quantity,
      this.additionalItems = const [],
      required this.itemId});

  // Method to increment the quantity
  void increment() {
    quantity++;
  }

  // Method to decrement the quantity
  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }

  // Calculate total price based on quantity
  int get totalPrice => itemPrice * quantity;

  // Add the copyWith method
  Cart copyWith({
    List<Item>? additionalItems,
    String? itemId,
    String? itemName,
    String? category,
    List<String>? image,
    int? itemPrice,
    int? quantity,
  }) {
    return Cart(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      category: category ?? this.category,
      image: image ?? this.image,
      itemPrice: itemPrice ?? this.itemPrice,
      quantity: quantity ?? this.quantity,
      additionalItems: additionalItems ?? this.additionalItems,
    );
  }
}
