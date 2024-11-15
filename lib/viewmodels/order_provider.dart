import 'package:aami/viewmodels/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:aami/models/order_model.dart';
import 'package:aami/services/order_service.dart';
import 'package:provider/provider.dart';

class OrderProvider with ChangeNotifier {
  final OrderService orderService = OrderService();
  List<Order> orders = [];
  bool isLoading = false;

  /// Fetch orders for the given login ID
  Future<void> fetchOrders(String loginId) async {
    isLoading = true;
    notifyListeners();

    try {
      final fetchedOrders = await orderService.fetchOrders(loginId);
      orders = fetchedOrders;
    } catch (e) {
      print("Error fetching orders: $e");
      orders = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Create a new order
  Future<void> createOrder({
    required BuildContext context,
    required String loginId,
    required int shippingAddressId,
    required List<Map<String, dynamic>> orderItems,
    required String totalAmount,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final newOrder = await orderService.createOrder(
        loginId: loginId,
        shippingAddressId: shippingAddressId,
        orderItems: orderItems,
        totalAmount: totalAmount,
      );

      // Add the new order to the list and notify listeners
      orders.add(newOrder);

      //if successfull clear the cart
      context.read<CartProvider>().clearCart();
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
