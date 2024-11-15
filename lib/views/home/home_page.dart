import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/viewmodels/product_provider.dart';
import 'package:aami/views/product/all_product.dart';
import 'package:aami/views/product/single_product.dart';
import 'package:aami/widgets/cards/productcard.dart';
import 'package:aami/widgets/loadinganimation.dart';
import 'package:aami/widgets/searchbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final searchProvider = Provider.of<ProductProvider>(context);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final String name = authProvider.name!;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Hello $name',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 28.sp),
                ),
                Text(
                  'Welcome to Aami Store',
                  style: Theme.of(context).textTheme.bodySmall!,
                ),
                CustomSearchBar(
                  isLoading: searchProvider.isSearchLoading,
                  onSearch: (query) async {
                    if (query.isNotEmpty) {
                      setState(() {
                        searchQuery = query;
                      });
                      await searchProvider.searchProducts(query);
                      if (searchProvider.searchResults.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProduct(
                              searchResults: searchProvider.searchResults,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  onChanged: (query) async {
                    if (query.isNotEmpty) {
                      setState(() {
                        searchQuery = query;
                      });
                      await searchProvider.fetchSuggestions(query);
                    } else {
                      setState(() {
                        searchQuery = '';
                      });
                      searchProvider.clearSearch();
                    }
                  },
                ),
                if (searchQuery.isNotEmpty &&
                    searchProvider.suggestions.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchProvider.suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = searchProvider.suggestions[index];
                      return ListTile(
                        tileColor: Theme.of(context).colorScheme.surface,
                        title: Text(
                          suggestion,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onTap: () async {
                          setState(() {
                            searchQuery = suggestion;
                          });
                          await searchProvider.searchProducts(suggestion);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllProduct(
                                searchResults: searchProvider.searchResults,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Arrivals',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProduct(),
                          ),
                        );
                      },
                      child: Text(
                        'View All',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Consumer<ProductProvider>(
                  builder: (context, productProvider, _) {
                    if (productProvider.isLoading) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (productProvider.products.isEmpty) {
                      return Center(
                        child: Text(
                          'No products available',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    } else {
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SingleProduct(productID: product.id),
                                ),
                              );
                            },
                            child: ProductCard(
                              productId: product.id,
                              title: product.title,
                              price: product.price,
                              image: product.images.isNotEmpty
                                  ? product.images[0]
                                  : 'https://via.placeholder.com/150',
                            ),
                          );
                        },
                      );
                    }
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
