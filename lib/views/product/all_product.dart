import 'package:aami/viewmodels/product_provider.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/cards/productcard.dart';
import 'package:aami/widgets/loading%20cards/Lproductcard.dart';
import 'package:aami/widgets/loadinganimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllProduct extends StatelessWidget {
  final List<dynamic>? searchResults;

  AllProduct({Key? key, this.searchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final bool isSearchMode = searchResults != null;
    final allProductData =
        isSearchMode ? searchResults! : productProvider.products;

    return Scaffold(
      appBar: CustomAppbar(
        title: isSearchMode ? 'Search Results' : 'All Products',
      ),
      body: productProvider.isLoading && !isSearchMode
          ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: 4,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns in the grid
                              childAspectRatio:
                                  0.63, // Adjust aspect ratio as needed
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              return LoadingProductCard(
                              );
                            },
                          ),
          )
          : allProductData.isEmpty
              ? Center(
                  child: Text(
                    isSearchMode
                        ? 'No products found for your search.'
                        : 'No products available.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      Expanded(
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: allProductData.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns in the grid
                            childAspectRatio:
                                0.63, // Adjust aspect ratio as needed
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            final product = allProductData[index];
                            final String imageUrl = product.images.isNotEmpty
                                ? product.images[0]
                                : 'https://via.placeholder.com/150';
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
