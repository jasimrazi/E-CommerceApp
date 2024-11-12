import 'package:flutter/material.dart';
import 'package:aami/models/product_model.dart';
import 'package:aami/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService productService = ProductService();
  List<Product> products = [];
  Product? product;
  bool isLoading = false;

  Future<void> fetchProducts() async {
    if (products.isNotEmpty) return; // Use cached data if available

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
      // Fetch the product directly as a `Product` instance
      product = await productService.fetchSingleProduct(productID);

      if (product == null) {
        print("No product data found for ID: $productID");
      } else {
        print("Fetched Single Product ID: ${product!.id}");
      }
    } catch (e) {
      print("Error fetching product: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
