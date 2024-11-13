
class CartProduct {
  final int id;
  final String title;
  final String price;
  final List<String> imageUrls; // Assuming images are URLs
  final String size; // Added size field

  CartProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrls,
    required this.size, // Initialize the size parameter
  });

  // Modify the fromJson method to include the size field
  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      imageUrls:
          List<String>.from(json['images'].map((image) => image['image_url'])),
      size: json['size'] ?? '', 
    );
  }

  // Optional: If you need to send this data back in the request, you can use toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'images': imageUrls.map((url) => {'image_url': url}).toList(),
      'size': size,
    };
  }
}
