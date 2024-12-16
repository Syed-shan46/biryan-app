// Define the StateNotifier
import 'package:biriyani/features/shop/models/additional_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedItemsProvider extends StateNotifier<List<Item>> {
  SelectedItemsProvider() : super([]);

  // Method to set items (replace the current state
  void setItems(List<Item> items) {
    state = items;
  }

  // Method to add an item to the selected list
  void addItem(Item item) {
    if (!state.contains(item)) {
      state = [...state, item];
    }
  }

  // Update selected items
  void updateItems(List<Item> newItems) {
    state = newItems; // Update the state with the new list of items
  }

  // Method to remove an item from the selected list
  void removeItem(Item item) {
    state = state.where((existingItem) => existingItem != item).toList();
  }
}

final selectedItemsProvider =
    StateNotifierProvider<SelectedItemsProvider, List<Item>>(
  (ref) => SelectedItemsProvider(),
);
