import 'package:aami/viewmodels/product_provider.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/cards/productcard.dart';
import 'package:aami/widgets/loadinganimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllProduct extends StatelessWidget {
  AllProduct({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final allProductData = productProvider.products;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'All Products',
      ),
      body: productProvider.isLoading
          ? Center(child: CustomLoading())
          : Padding(
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        childAspectRatio: 0.63, // Adjust aspect ratio as needed
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        final product = allProductData[index];
                        final String imageUrl = product.images[0];
                        final String title = product.title;
                        final String price = product.price;
                        final int id = product.id;

                        return ProductCard(
                          productId: id,
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
