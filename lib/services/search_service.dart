import 'dart:convert';
import 'package:aami/models/product_model.dart'; 
import 'package:aami/utils/url.dart';
import 'package:http/http.dart' as http;

class SearchService {
  /// Fetch product suggestions (GET request)
  Future<List<String>> fetchSuggestions(String query) async {
    final url = Uri.parse('$baseUrl/search?search_query=$query');
    final response = await http.get(
      url.replace(queryParameters: {'search_query': query}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final suggestions = (data['suggestion'] as List)
          .map((item) => item['product_title'] as String)
          .toList();
      return suggestions;
    } else {
      throw Exception(
          json.decode(response.body)['error'] ?? 'Failed to fetch suggestions');
    }
  }

  /// Search for products (POST request)
  Future<List<Product>> searchProducts(String query) async {
    final url = Uri.parse('$baseUrl/search/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'search_query': query}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final products =
          (data['data'] as List).map((item) => Product.fromJson(item)).toList();
      return products;
    } else if (response.statusCode == 404) {
      throw Exception('No products found');
    } else {
      throw Exception(
          json.decode(response.body)['message'] ?? 'Failed to fetch products');
    }
  }
}
