class Product {
  final int id;
  final List<String> images;
  final List<String> sizes;
  final String title;
  final String description;
  final String price;
  final String category;
  final String brand;

  Product({
    required this.id,
    required this.images,
    required this.sizes,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.brand,
  });

  // From JSON for a single product
  factory Product.fromJson(Map<String, dynamic> json) {
    var productData = json['data'] != null && (json['data'] as List).isNotEmpty
        ? (json['data'] as List)[0] // Get the first product from 'data'
        : null;

    if (productData == null) {
      throw Exception("Product data is missing.");
    }

    // Parse the 'images' and 'sizes' properly
    return Product(
      id: productData['id'] ?? 0, // Default to 0 if id is null
      images: List<String>.from(
          productData['images']?.map((img) => img['image_url'] ?? '') ?? []),
      sizes: List<String>.from(
          productData['sizes']?.map((size) => size['size'] ?? '') ?? []),
      title: productData['title'] ?? '',
      description: productData['description'] ?? '',
      price: productData['price'] ?? '',
      category: productData['category'] ?? '',
      brand: productData['brand'] ?? '',
    );
  }

  // From JSON for multiple products (e.g., from a list of products in the response)
  static List<Product> fromJsonList(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      return (json['data'] as List)
          .map((productData) => Product.fromJson({
                'data': [productData]
              }))
          .toList();
    } else {
      throw Exception("Invalid or empty product list data.");
    }
  }
}
