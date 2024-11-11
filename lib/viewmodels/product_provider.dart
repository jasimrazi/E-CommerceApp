import 'package:aami/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:aami/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService productService = ProductService();
  List<Product> products = [];
  Product? product;
  bool isLoading = false;

  Future<void> fetchProducts() async {
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
    isLoading = true;
    notifyListeners();

    try {
      final response = await productService.fetchSingleProduct(productID);

      if (response != null && response.isNotEmpty) {
        // Parse the single product data
        product = Product.fromJson(
            response); // Assuming the API returns a single product object

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
