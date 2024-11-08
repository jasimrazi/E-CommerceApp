import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String image;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
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
                    fit: BoxFit
                        .contain, // Ensures the image fits within the container
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
                    Icons.favorite_border,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    // Add functionality to handle favorite action here
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
          Text('\$${price.toStringAsFixed(2)}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
