import 'package:flutter/material.dart';
import 'package:aami/models/cartproduct_model.dart';
import 'package:aami/services/cart_service.dart';

class CartProvider with ChangeNotifier {
  final CartService cartService = CartService();
  List<CartProduct> cartItems = [];
  bool isLoading = false;

 

  // Fetch cart items for a user
  Future<void> fetchCart(String loginId) async {
    isLoading = true;
    notifyListeners();
    try {
      cartItems = await cartService.fetchCart(loginId);
    } catch (e) {
      print("Error fetching cart: $e");
      cartItems = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Add a product to the cart
  Future<String> addToCart(String loginId, int productId, String size) async {
    isLoading = true;
    notifyListeners();
    try {
      final message = await cartService.addToCart(loginId, productId, size);
      // await fetchCart(loginId); // Refresh the cart after adding an item
      return message;
    } catch (e) {
      print("Error adding to cart: $e");
      return 'Failed to add to cart';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Clear the cart items locally (not from the API)
  void clearCart() {
    cartItems = [];
    notifyListeners();
  }
}