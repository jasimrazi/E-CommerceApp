class Review {
  final int userId;
  final String username;
  final int productId;
  final int rating;
  final String comment;
  final DateTime dateCreated;
  final DateTime dateUpdated;

  Review({
    required this.userId,
    required this.username,
    required this.productId,
    required this.rating,
    required this.comment,
    required this.dateCreated,
    required this.dateUpdated,
  });

  // Factory method to create a Review instance from JSON data
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? '',
      productId: json['product_id'] ?? 0,
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      dateCreated: DateTime.parse(json['date_created'] ?? ''),
      dateUpdated: DateTime.parse(json['date_updated'] ?? ''),
    );
  }

  // Method to convert Review instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'product_id': productId,
      'rating': rating,
      'comment': comment,
      'date_created': dateCreated.toIso8601String(),
      'date_updated': dateUpdated.toIso8601String(),
    };
  }
}

class ReviewResponse {
  final List<Review> reviews;

  ReviewResponse({required this.reviews});

  // Factory method to create ReviewResponse instance from JSON data
  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  // Method to convert ReviewResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
}
