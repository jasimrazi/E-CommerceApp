import 'dart:convert';
import 'package:aami/models/review_model.dart';
import 'package:aami/utils/url.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  // Fetch reviews for a specific product
  Future<List<Review>> getReviews(int productId) async {
    final url = Uri.parse('$baseUrl/reviews/$productId');
    try {
      final response = await http.get(url);


      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final reviewResponse = ReviewResponse.fromJson(responseData);
        return reviewResponse.reviews;
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (e) {
      throw Exception('Error fetching reviews: $e');
    }
  }

  // Post a review for a product
  Future<String> postReview({
    required int productId,
    required String loginId,
    required int rating,
    required String comment,
  }) async {
    final url = Uri.parse(
        '$baseUrl/reviews/add/$productId/$loginId'); // Replace with the correct endpoint
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'rating': rating,
          'comment': comment,
        }),
      );

      if (response.statusCode == 201) {
        return 'Review posted successfully';
      } else {
        throw Exception('Failed to post review');
      }
    } catch (e) {
      throw Exception('Error posting review: $e');
    }
  }
}
