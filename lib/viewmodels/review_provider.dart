import 'package:aami/models/review_model.dart';
import 'package:aami/services/review_service.dart';
import 'package:flutter/material.dart';

class ReviewProvider with ChangeNotifier {
  final ReviewService reviewService = ReviewService();

  // List to store fetched reviews
  List<Review> reviews = [];

  // Loading state for fetching reviews
  bool isLoading = false;

  // Error message if fetching or posting fails
  String? errorMessage;

  // Fetch reviews for a specific product
  Future<void> fetchReviews(int productId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    if (reviews.isNotEmpty) return; // Use cached data if available



    try {
      reviews = await reviewService.getReviews(productId);

    } catch (e) {
      errorMessage = 'Failed to load reviews: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Post a review for a specific product
  Future<void> postReview({
    required int productId,
    required String loginId,
    required int rating,
    required String comment,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await reviewService.postReview(
        productId: productId,
        loginId: loginId,
        rating: rating,
        comment: comment,
      );
      // After posting, fetch updated reviews
      await fetchReviews(productId);
    } catch (e) {
      errorMessage = 'Failed to post review: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
