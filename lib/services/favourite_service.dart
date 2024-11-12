import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aami/models/product_model.dart';
import 'package:aami/utils/url.dart';

class FavouriteService {
  // Add to Favourite
  Future<String> addToFav(String loginID, int productID) async {
    final url = Uri.parse('$baseUrl/favourites/add/$loginID/$productID');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 201) {
        return "Product added to favourites";
      } else if (response.statusCode == 200) {
        return "Product removed from favourites";
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error'] ?? "Failed to update favourites");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  // Fetch All Favourite Products
  // Fetch All Favourite Products
  Future<List<Product>> fetchFavourites(String loginID) async {
    final url = Uri.parse('$baseUrl/favourites/user/$loginID');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data =
            responseData['data']; // Access the 'data' key

        // Parse the list of products from the 'data' field
        return data
            .map((productJson) => Product.fromJson(productJson))
            .toList();
      }
      if (response.statusCode == 400) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        throw Exception(responseData["message"]);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error'] ?? "Failed to fetch favourites");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
