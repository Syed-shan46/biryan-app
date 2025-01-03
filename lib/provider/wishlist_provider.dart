import 'package:biriyani/features/shop/models/wishlist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, Favorite>>((ref) {
  return FavoriteNotifier();
});

class FavoriteNotifier extends StateNotifier<Map<String, Favorite>> {
  FavoriteNotifier() : super({});

  void addProductToFavorite({
    required String itemName,
    required final int itemPrice,
    required final String category,
    required final List<String> image,
    required final int? quantity,
    required final String productId,
  }) {
    state = {
      ...state,
      productId: Favorite(
          itemName: itemName,
          itemPrice: itemPrice,
          category: category,
          image: image,
          quantity: 1, // Set default quantity to 1
          productId: productId),
    };
  }

  void removeFavItem(String productId) {
    state.remove(productId);

    state = {...state};
  }

  Map<String, Favorite> get getFavItems => state;
}
