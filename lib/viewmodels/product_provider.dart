import 'package:aami/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:aami/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService productService = ProductService();
  List<Product> products = [];
  Product? product;
  bool isLoading = false;

  Future<void> fetchProducts() async {
    // Check if products are already cached
    if (products.isNotEmpty) return; // Return immediately if data is cached

    isLoading = true;
    notifyListeners();

    try {
      products = await productService.fetchProducts();
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSingleProduct(int productID) async {
    // If the product is already cached, no need to call the API
    if (product != null && product!.id == productID) return;

    isLoading = true;
    notifyListeners();

    try {
      final response = await productService.fetchSingleProduct(productID);

      if (response != null && response.isNotEmpty) {
        // Parse the single product data
        product = Product.fromJson(response);

        if (product == null) {
          print("Product is null after fetchSingleProduct.");
        } else {
          print("Product ID: ${product!.id}");
        }
      } else {
        print("No product data found for ID: $productID");
      }
    } catch (e) {
      print("Error fetching product: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
