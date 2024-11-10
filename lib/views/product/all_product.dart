import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/cards/productcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProduct extends StatelessWidget {
  AllProduct({super.key});

  // Sample data for all products
  final List<Map<String, dynamic>> allProductData = [
    {
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
      ],
      "title": "Nike Club Fleece",
      "description":
          "The Nike Throwback Pullover Hoodie is made from premium French terry fabric that blends a performance feel.",
      "price": "120.00",
      "category": "Hoodie",
      "brand": "Nike",
    },
    {
      "id": 2,
      "images": [
        {
          "id": 1,
          "image_url":
              "http://res.cloudinary.com/fakestore/image/upload/v1730878673/sample_image.jpg",
        },
      ],
      "title": "Adidas Essentials",
      "description":
          "A classic Adidas hoodie made for comfort and style.",
      "price": "100.00",
      "category": "Hoodie",
      "brand": "Adidas",
    },
    // Additional products can be added here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'All Products',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: allProductData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  childAspectRatio: 0.63, // Adjust aspect ratio as needed
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final product = allProductData[index];
                  final String imageUrl = product['images'][0]['image_url'];
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
