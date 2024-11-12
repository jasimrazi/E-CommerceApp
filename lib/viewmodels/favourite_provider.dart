import 'package:aami/models/product_model.dart';
import 'package:aami/services/favourite_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteProvider with ChangeNotifier {
  final FavouriteService favouritesService = FavouriteService();
  List<int> favouriteProductIds = []; // Holds the IDs of favourite products
  List<Product> favouriteProducts =
      []; // Holds full product data for favourites
  bool isLoading = false;

  FavouriteProvider() {
    _loadFavouriteProductIds(); // Load saved favourite product IDs on initialization
  }

  // Toggles the favourite status of a product
  Future<void> toggleFavourite(String loginid, int productid) async {
    isLoading = true;
    notifyListeners();

    try {
      final message = await favouritesService.addToFav(loginid, productid);
      print(message);

      // Toggle local favourite status based on the response message
      if (message == "Product added to favourites") {
        favouriteProductIds.add(productid);
      } else if (message == "Product removed from favourites") {
        favouriteProductIds.remove(productid);
      }
      await _saveFavouriteProductIds(); // Save updated favourite IDs to SharedPreferences
    } catch (e) {
      print("Error toggling favourite: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Fetch all favourite products for the user
  Future<void> fetchFavouriteProducts(String loginid) async {
    isLoading = true;
    notifyListeners();

    try {
      await _loadFavouriteProductIds(); // Load favourite IDs from SharedPreferences first
      favouriteProducts = await favouritesService.fetchFavourites(loginid);
      favouriteProductIds =
          favouriteProducts.map((product) => product.id).toList();
      await _saveFavouriteProductIds(); // Update SharedPreferences with current favourites
    } catch (e) {
      print("Error fetching favourite products: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Check if a product is in favourites
  bool isFavourite(int productid) {
    return favouriteProductIds.contains(productid);
  }

  // Save favourite product IDs to SharedPreferences
  Future<void> _saveFavouriteProductIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'favouriteProductIds',
      favouriteProductIds.map((id) => id.toString()).toList(),
    );
  }

  // Load favourite product IDs from SharedPreferences
  Future<void> _loadFavouriteProductIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedIds = prefs.getStringList('favouriteProductIds');
    if (savedIds != null) {
      favouriteProductIds = savedIds.map((id) => int.parse(id)).toList();
      notifyListeners();
    }
  }
}
