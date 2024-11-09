import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/imagecard.dart';
import 'package:aami/widgets/reviewcard.dart';
import 'package:aami/widgets/sizecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class SingleProduct extends StatelessWidget {
  SingleProduct({super.key});

  final Map<String, dynamic> product = {
    'name': 'Nike Sportswear Club Fleece',
    'price': 79.99,
    'description':
        'A cozy and comfortable fleece hoodie, perfect for everyday wear with a classic Nike design.',
    'images': [
      'https://i.pinimg.com/736x/6a/fb/b2/6afbb2dc2be4acc1ce4a92afea760c22.jpg',
      'https://example.com/images/nike_hoodie_back.png',
      'https://example.com/images/nike_hoodie_side.png',
      'https://example.com/images/nike_hoodie_side.png',
    ],
    'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
  };

  final List<Map<String, dynamic>> reviews = [
    {
      "user_id": 1,
      "username": "Ayisha",
      "product_id": 1,
      "rating": 3,
      "comment":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet",
      "date_created": "2024-11-06T12:52:14.875967Z",
      "date_updated": "2024-11-06T13:00:10.538496Z"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(
        isCart: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                height: 400.h,
                child: Image.network(
                  product['images'][0],
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 178.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name',
                            style: Theme.of(context).textTheme.bodySmall!),
                        Text(product['name'],
                            style: Theme.of(context).textTheme.bodyLarge!),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price',
                          style: Theme.of(context).textTheme.bodySmall!),
                      Text('\$${product['price'].toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyLarge!),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 75.h, // Setting a fixed height for the image list
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: product['images'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ImageCard(image: product['images'][index]),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Size',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 50.h, // Setting a fixed height for the image list
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: product['sizes'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizeCard(size: product['sizes'][index]),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Description',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 10.h),
              ReadMoreText(
                product['description'],
                trimMode: TrimMode.Line,
                trimLines: 2,
                colorClickableText: Theme.of(context).colorScheme.primary,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary), // Explicitly setting color to the bodySmall color in the theme
                moreStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h),
              ReviewCard(review: reviews[0]),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavButton(
        onTap: () {},
        title: 'Add to Cart',
      ),
    );
  }
}
