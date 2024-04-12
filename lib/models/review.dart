class Review {
  final String reviewId;
  final String orderId; // Foreign key for order
  final String productId; // Foreign key for product
  final String comment;
  final double rating;

  Review({
    required this.reviewId,
    required this.orderId,
    required this.productId,
    required this.comment,
    required this.rating,
  });
}
