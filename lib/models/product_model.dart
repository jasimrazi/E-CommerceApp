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
    // Access the first element of 'data' if 'data' exists and is a list with at least one item
    Map<String, dynamic> productData;
    if (json['data'] != null &&
        json['data'] is List &&
        json['data'].isNotEmpty) {
      productData = json['data'][0];
    } else {
      productData = json;
    }

    // Extract fields individually for clarity
    int id = productData['id'] ?? 0;
    List<String> images = [];
    if (productData['images'] != null && productData['images'] is List) {
      images = List<String>.from(
          productData['images'].map((img) => img['image_url'] ?? ''));
    }

    List<String> sizes = [];
    if (productData['sizes'] != null && productData['sizes'] is List) {
      sizes = List<String>.from(
          productData['sizes'].map((size) => size['size'] ?? ''));
    }

    String title = productData['title'] ?? '';
    String description = productData['description'] ?? '';
    String price = productData['price'] ?? '';
    String category = productData['category'] ?? '';
    String brand = productData['brand'] ?? '';

    return Product(
      id: id,
      images: images,
      sizes: sizes,
      title: title,
      description: description,
      price: price,
      category: category,
      brand: brand,
    );
  }


  // From JSON for a list of products
  static List<Product> fromJsonList(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      return (json['data'] as List<dynamic>)
          .map((productData) => Product.fromJson(productData))
          .toList();
    } else {
      throw Exception("Invalid or empty product list data.");
    }
  }
}
