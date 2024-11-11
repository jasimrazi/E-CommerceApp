import 'package:aami/viewmodels/product_provider.dart';
import 'package:aami/views/product/single_product.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/cards/productcard.dart';
import 'package:aami/widgets/loadinganimation.dart';
import 'package:aami/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              return SingleChildScrollView(
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
                    SizedBox(height: 20.h),
                    // Display a loading indicator while loading, or a message if products are empty
                    if (productProvider.isLoading)
                      Center(child: CustomLoading())
                    else if (productProvider.products.isEmpty)
                      Center(
                        child: Text(
                          'No products available',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    else
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: productProvider.products.length,
                        itemBuilder: (context, index) {
                          final product = productProvider.products[index];
                          return GestureDetector(
                            onTap: () {
                              print('HomePage: ProductID: ${product.id}');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SingleProduct(productID: product.id),
                                ),
                              );
                            },
                            child: ProductCard(
                              title: product.title,
                              price: product.price,
                              image: product.images.isNotEmpty
                                  ? product.images[0]
                                  : 'https://via.placeholder.com/150', // Placeholder image if none exist
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
