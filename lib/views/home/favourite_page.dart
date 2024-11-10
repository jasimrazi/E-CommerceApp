import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/cards/productcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouritePage extends StatelessWidget {
  FavouritePage({super.key});

  // Sample data for favorite products based on the API response
  final List<Map<String, dynamic>> favouriteData = [
    {
      "user_id": 1,
      "product": {
        "id": 1,
        "images": [
          {
            "id": 1,
            "image_url":
                "http://res.cloudinary.com/fakestore/image/upload/v1730878670/mmw1cwpici7eh2js8i5w.jpg",
          },
          {
            "id": 2,
            "image_url":
                "http://res.cloudinary.com/fakestore/image/upload/v1730878671/f04u1eoz1nafs3tygmzj.avif",
          },
          {
            "id": 3,
            "image_url":
                "http://res.cloudinary.com/fakestore/image/upload/v1730878672/imqpfis76yibnwludkgb.avif",
          }
        ],
        "title": "Nike Club Fleece",
        "description":
            "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel.",
        "price": "120.00",
        "category": "Hoodie",
        "brand": "Nike",
      },
      "date_added": "2024-11-09T14:32:59.312055Z"
    },
    // Additional favorite items can be added here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: favouriteData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  childAspectRatio: 0.63, // Adjust aspect ratio as needed
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final product = favouriteData[index]['product'];
                  final String imageUrl = product['images'][0]
                      ['image_url']; // Using the first image
                  final String title = product['title'];
                  final String price = product['price'];

                  return ProductCard(
                    title: title,
                    image: imageUrl,
                    price: price,
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
