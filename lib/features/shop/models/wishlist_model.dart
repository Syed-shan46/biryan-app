class Favorite {
  final String itemName;
  final int itemPrice;
  final String category;
  final List<String> image;
  int quantity;
  final String productId;

  Favorite(
      {required this.itemName,
      required this.itemPrice,
      required this.category,
      required this.image,
      required this.quantity,
      required this.productId});

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
  Favorite copyWith({
    String? productId,
    String? itemName,
    String? category,
    List<String>? image,
    int? productPrice,
    int? quantity,
  }) {
    return Favorite(
      productId: productId ?? this.productId,
      itemName: itemName ?? this.itemName,
      category: category ?? this.category,
      image: image ?? this.image,
      itemPrice: productPrice ?? itemPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}
