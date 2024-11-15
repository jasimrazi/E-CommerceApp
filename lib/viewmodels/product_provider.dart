import 'dart:async';
import 'package:flutter/material.dart';
import 'package:aami/models/product_model.dart';
import 'package:aami/services/product_service.dart';
import 'package:aami/services/search_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService productService = ProductService();
  final SearchService searchService = SearchService();

  List<Product> products = [];
  List<Product> searchResults = [];
  List<String> suggestions = [];
  Product? product;
  bool isLoading = false;
  String errorMessage = '';
  int? productID;

  Timer? debounce;

  /// Fetch all products and cache the data
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

  /// Fetch a single product by ID
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

  /// Fetch suggestions based on a query with debouncing
  Future<void> fetchSuggestions(String query) async {
    if (query.isEmpty) {
      suggestions = [];
      notifyListeners();
      return;
    }

    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 300), () async {
      isLoading = true;
      errorMessage = '';
      notifyListeners();

      try {
        suggestions = await searchService.fetchSuggestions(query);
      } catch (e) {
        errorMessage = 'Failed to fetch suggestions: ${e.toString()}';
      } finally {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  /// Search products based on a query
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) return;

    isLoading = true;
    errorMessage = '';
    searchResults = [];
    notifyListeners();

    try {
      searchResults = await searchService.searchProducts(query);
    } catch (e) {
      errorMessage = 'Failed to search products: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Clear search results and suggestions
  void clearSearch() {
    searchResults = [];
    suggestions = [];
    errorMessage = '';
    notifyListeners();
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }
}
