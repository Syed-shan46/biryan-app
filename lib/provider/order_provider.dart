import 'package:biriyani/features/shop/models/order_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderProvider extends StateNotifier<List<Order>> {
  OrderProvider() : super([]);
  // Reset the orders to an empty list
  void resetOrders() {
    state = [];
  }

  void setOrders(List<Order> orders) {
    state = orders;
  }

  
}

final orderProvider = StateNotifierProvider<OrderProvider, List<Order>>((ref) {
  return OrderProvider();
});
