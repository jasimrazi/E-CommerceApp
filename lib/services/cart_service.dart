import 'dart:convert';
import 'package:aami/models/cartproduct_model.dart';
import 'package:aami/utils/url.dart';
import 'package:http/http.dart' as http;

class CartService {
  // Fetch cart details for a user
  Future<List<CartProduct>> fetchCart(String loginId) async {
    final url = Uri.parse('$baseUrl/carts/user/$loginId');

    try {
      final response = await http.get(url);

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        // Parse the cart items and return a list of CartProduct
        return (data[0]['cart_items'] as List)
            .map((item) => CartProduct.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch cart');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Add a product to the cart
  Future<String> addToCart(String loginId, int productId, String size) async {
    final url = Uri.parse('$baseUrl/carts/add/$loginId/$productId/$size');

    try {
      final response = await http.post(url);

      if (response.statusCode == 201) {
        final data = json.decode(response.body);

        return data['message']; // Successfully added to cart
      } else if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message']; //Item already exists
      } else {
        throw Exception('Failed to add to cart');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
