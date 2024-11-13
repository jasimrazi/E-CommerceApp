import 'package:aami/models/review_model.dart';
import 'package:aami/services/review_service.dart';
import 'package:flutter/material.dart';

class ReviewProvider with ChangeNotifier {
  final ReviewService reviewService = ReviewService();

  // List to store fetched reviews
  List<Review> reviews = [];

  // Loading state for fetching reviews
  bool isLoading = false;

  //Bool for checking if its coming from Post function
  bool addReviewFetch = false;

  // Error message if fetching or posting fails
  String? errorMessage;

  // New flag to track if reviews were fetched
  bool hasFetchedReviews = false;
  // Fetch reviews for a specific product

  Future<void> fetchReviews(int productId) async {
    if ((isLoading || hasFetchedReviews) && !addReviewFetch) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {

      reviews = await reviewService.getReviews(productId);

      // Set hasFetchedReviews to true after the first attempt
      hasFetchedReviews = true;
    } catch (e) {
      print('Error in fetchReviews: ${e.toString()}');
      errorMessage = 'Failed to load reviews: $e';
      reviews =
          []; // Ensure reviews are empty on error to stop infinite loading
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

      //set bool to true for second fetching
      addReviewFetch = true;

      // After posting, fetch updated reviews
      await fetchReviews(productId);
    } catch (e) {
      errorMessage = 'Failed to post review: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Clear review list
  void clearReviews() {
    reviews = [];
    hasFetchedReviews = false;
    notifyListeners();
  }
}
