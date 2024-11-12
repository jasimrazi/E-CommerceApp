import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/viewmodels/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final int productId;
  final String title;
  final String price;
  final String image;

  const ProductCard({
    super.key,
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // Access FavouriteProvider to check if the product is a favourite
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final loginID = authProvider.loginId!;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Product image container with a defined height
              Container(
                width: double.infinity,
                height: 200.h,
                margin: EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 200.h,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, size: 50);
                    },
                  ),
                ),
              ),
              // Favorite icon in the top right corner
              Positioned(
                top: 1,
                right: 1,
                child: IconButton(
                  icon: Icon(
                    favouriteProvider.isFavourite(productId)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: favouriteProvider.isFavourite(productId)
                        ? Colors.red
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    // Toggle favorite status on button press
                    favouriteProvider.toggleFavourite(
                        loginID, productId);
                  },
                ),
              ),
            ],
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          Text(
            '\$$price',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
