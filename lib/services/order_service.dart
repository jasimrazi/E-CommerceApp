import 'dart:convert';
import 'package:aami/models/order_model.dart';
import 'package:aami/utils/url.dart';
import 'package:http/http.dart' as http;

class OrderService {
  /// Fetch orders for a specific user
  Future<List<Order>> fetchOrders(String loginId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/order/$loginId'),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return Order.fromJsonList(data);
      } else {
        throw Exception('Failed to fetch orders');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Create a new order
  Future<Order> createOrder({
    required String loginId,
    required int shippingAddressId,
    required List<Map<String, dynamic>> orderItems,
    required String totalAmount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/order/create/$loginId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'shipping_address': shippingAddressId,
          'order_items': orderItems,
          'total_amount': totalAmount,
        }),
      );
      print('createOrderService');
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Order.fromJson(data);
      } else {
        throw Exception('Failed to create order');
      }
    } catch (e) {
      rethrow;
    }
  }
}
