import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/viewmodels/favourite_provider.dart';
import 'package:aami/widgets/cards/productcard.dart';
import 'package:aami/widgets/loadinganimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();
    // Fetch favourite products on page load using initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final favouriteProvider =
          Provider.of<FavouriteProvider>(context, listen: false);
      final loginID = authProvider.loginId!;
      favouriteProvider.fetchFavouriteProducts(loginID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Expanded(
              child: Consumer<FavouriteProvider>(
                builder: (context, favouriteProvider, child) {
                  // Display loading indicator if data is still loading
                  if (favouriteProvider.isLoading) {
                    return Center(child: CustomLoading());
                  }

                  // If no favourites are available, display a placeholder message
                  if (favouriteProvider.favouriteProducts.isEmpty) {
                    return Center(child: Text("No favourite products found."));
                  }

                  // Display favourite products in a grid view
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: favouriteProvider.favouriteProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      childAspectRatio: 0.63, // Adjust aspect ratio as needed
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      final product =
                          favouriteProvider.favouriteProducts[index];
                      final String imageUrl =
                          product.images[0]; // Use the first image
                      final String title = product.title;
                      final String price = product.price.toString();

                      return ProductCard(
                        productId: product.id,
                        title: title,
                        image: imageUrl,
                        price: price,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
