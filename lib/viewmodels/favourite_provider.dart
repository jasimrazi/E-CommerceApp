import 'package:aami/models/product_model.dart';
import 'package:aami/services/favourite_service.dart';
import 'package:flutter/material.dart';

class FavouriteProvider with ChangeNotifier {
  final FavouriteService favouritesService = FavouriteService();
  List<int> favouriteProductIds = []; // Holds the IDs of favourite products
  List<Product> favouriteProducts =
      []; // Holds full product data for favourites
  bool isLoading = false;

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
    print('loading 1');
    notifyListeners();

    try {
      // Fetch favourites from the service
    print('loading 2');

      favouriteProducts = await favouritesService.fetchFavourites(loginid);
    print('loading 3');

      print('Fav Products: $favouriteProducts');
      favouriteProductIds =
          favouriteProducts.map((product) => product.id).toList();
      print('Fav IDs: $favouriteProductIds');
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
}
