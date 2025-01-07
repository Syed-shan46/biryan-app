import 'package:biriyani/features/shop/models/additional_model.dart';
import 'package:biriyani/features/shop/models/cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, Cart>>((ref) {
  return CartNotifier();
});

class CartItem {
  final String id;
  final int quantity;

  CartItem({required this.id, required this.quantity});
}

class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({});

  // Method to add item to the cart
  void addItemToCart({
    required String itemName,
    required final int itemPrice,
    required final String category,
    required final List<String> image,
    required final int? quantity,
    required final String itemId,
    List<Item>? additionalItems,
  }) {
    try {
      if (state.containsKey(itemId)) {
        // item already exists in the cart, increment the quantity
        state = {
          ...state,
          itemId: Cart(
            itemName: state[itemId]!.itemName,
            itemPrice: state[itemId]!.itemPrice,
            category: state[itemId]!.category,
            image: state[itemId]!.image,
            quantity: state[itemId]!.quantity,
            itemId: itemId,
            additionalItems: state[itemId]!.additionalItems,
          ),
        };
      } else {
        // item does not exist in the cart, add as new
        state = {
          ...state,
          itemId: Cart(
            itemName: itemName,
            itemPrice: itemPrice,
            category: category,
            image: image,
            quantity: quantity!, // Set default quantity to 1
            itemId: itemId,
            additionalItems: additionalItems ?? [],
          ),
        };
      }
    } catch (e) {
      // Handle any errors
      print('Error while updating cart item for item $itemId: $e');
    }
  }

  void incrementCartItem(String itemId) {
    if (state.containsKey(itemId)) {
      final cartItem = state[itemId]!;
      final newQuantity = cartItem.quantity + 1;

      state = {
        ...state,
        itemId: cartItem.copyWith(quantity: newQuantity),
      };
    }
  }

  List<Item> getAdditionalItems(String itemId) {
    return state[itemId]?.additionalItems ?? [];
  }

  void decrementCartItem(String itemId) {
    if (state.containsKey(itemId)) {
      final cartItem = state[itemId]!;
      if (cartItem.quantity > 1) {
        // Prevent quantity from going below 1
        final newQuantity = cartItem.quantity - 1;

        state = {
          ...state,
          itemId: cartItem.copyWith(quantity: newQuantity),
        };
      } else {
        removeCartItem(itemId);
      }
    }
  }

  void removeCartItem(String itemId) {
    state.remove(itemId);

    state = {...state};
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    state.forEach((itemId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.itemPrice;
    });
    return totalAmount;
  }

  // Update quantity of an item in the cart
  void updateQuantity(String productId, int quantity) {
    if (state.containsKey(productId)) {
      state = {
        ...state,
        productId: state[productId]!.copyWith(quantity: quantity),
      };
    }
  }

  int getQuantity(String productId) {
    return state[productId]?.quantity ?? 1;
  }

  // Method to calculate the total quantity
  int get totalQuantity {
    return state.values.fold(0, (sum, cartItem) => sum + cartItem.quantity);
  }

  Map<String, Cart> get getCartItems => state;
}
