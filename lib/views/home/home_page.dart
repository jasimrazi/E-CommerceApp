import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/cards/productcard.dart';
import 'package:aami/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Sample list of products
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Product 1Product 1Product 1Product1Product',
      'price': 49.99,
      'image':
          'https://i.pinimg.com/736x/6a/fb/b2/6afbb2dc2be4acc1ce4a92afea760c22.jpg'
    },
    {
      'title': 'Product 2',
      'price': 59.99,
      'image':
          'https://i.pinimg.com/736x/6a/fb/b2/6afbb2dc2be4acc1ce4a92afea760c22.jpg'
    },
    {
      'title': 'Product 3',
      'price': 19.99,
      'image':
          'https://i.pinimg.com/736x/6a/fb/b2/6afbb2dc2be4acc1ce4a92afea760c22.jpg'
    },
    {
      'title': 'Product 4',
      'price': 89.99,
      'image':
          'https://i.pinimg.com/736x/6a/fb/b2/6afbb2dc2be4acc1ce4a92afea760c22.jpg'
    },
    {
      'title': 'Product 5',
      'price': 29.99,
      'image':
          'https://i.pinimg.com/736x/6a/fb/b2/6afbb2dc2be4acc1ce4a92afea760c22.jpg'
    },
    {
      'title': 'Product 6',
      'price': 39.99,
      'image':
          'https://i.pinimg.com/736x/6a/fb/b2/6afbb2dc2be4acc1ce4a92afea760c22.jpg'
    },
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 28.sp),
                ),
                Text('Welcome to Aami',
                    style: Theme.of(context).textTheme.bodySmall!),
                CustomSearchBar(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Arrivals',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'View All',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height: 20.h), // Add some spacing

                // Use GridView.builder with itemCount limited to 4
                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap:
                      true, // Ensures it takes only the necessary height
                  physics:
                      NeverScrollableScrollPhysics(), // Disable GridView scrolling
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns
                    childAspectRatio: 0.65, // Adjust ratio as needed
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: 4, // Display only 4 items
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      title: product['title'],
                      price: product['price'],
                      image: product['image'],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
