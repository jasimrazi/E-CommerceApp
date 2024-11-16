import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/viewmodels/cart_provider.dart';
import 'package:aami/viewmodels/product_provider.dart';
import 'package:aami/viewmodels/review_provider.dart';
import 'package:aami/viewmodels/selection_provider.dart';
import 'package:aami/views/review/allreview_page.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/cards/imagecard.dart';
import 'package:aami/widgets/cards/reviewcard.dart';
import 'package:aami/widgets/cards/sizecard.dart';
import 'package:aami/widgets/loading%20cards/Lreviewcard.dart';
import 'package:aami/widgets/loadinganimation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SingleProduct extends StatefulWidget {
  final int productID;
  SingleProduct({Key? key, required this.productID}) : super(key: key);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      final reviewProvider =
          Provider.of<ReviewProvider>(context, listen: false);
      final selectionProvider =
          Provider.of<SelectionProvider>(context, listen: false);

      productProvider.fetchSingleProduct(widget.productID);
      reviewProvider.clearReviews();
      selectionProvider.clearSelectedSize();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final reviewProvider = Provider.of<ReviewProvider>(context);
    final selectionProvider = Provider.of<SelectionProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final product = productProvider.product;
    productProvider.productID = widget.productID;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(),
      body: productProvider.isLoading
          ? const Center(child: CupertinoActivityIndicator())
          : product == null
              ? Center(child: Text('Product not found'))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Main Image Display
                        Consumer<SelectionProvider>(
                          builder: (context, selectionProvider, _) {
                            return Container(
                              width: double.maxFinite,
                              height: 400.h,
                              child: Image.network(
                                product.images[
                                    selectionProvider.selectedImageIndex],
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        // Product Title and Price
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!),
                                  Text(product.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price',
                                    style:
                                        Theme.of(context).textTheme.bodySmall!),
                                Text('\$${product.price}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        // Image Thumbnail List
                        SizedBox(
                          height: 75.h,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: product.images.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  selectionProvider.updateSelectedImage(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ImageCard(
                                    image: product.images[index],
                                    isSelected: index ==
                                        selectionProvider.selectedImageIndex,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // Size Selection
                        Text('Size',
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(height: 10.h),
                        SizedBox(
                          height: 50.h,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: product.sizes.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  selectionProvider.updateSelectedSize(
                                      index, product.sizes[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: SizeCard(
                                    size: product.sizes[index],
                                    isSelected: index ==
                                        selectionProvider.selectedSizeIndex,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // Product Description
                        Text('Description',
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(height: 10.h),
                        ReadMoreText(
                          product.description,
                          trimMode: TrimMode.Line,
                          trimLines: 2,
                          colorClickableText:
                              Theme.of(context).colorScheme.primary,
                          trimCollapsedText: ' Show more',
                          trimExpandedText: ' Show less',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          moreStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        SizedBox(height: 20.h),
                        // Reviews Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Reviews',
                                style: Theme.of(context).textTheme.bodyMedium),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AllReviewPage(),
                                    ));
                              },
                              child: Text(
                                'View All',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        // Review section with VisibilityDetector
                        VisibilityDetector(
                          key: Key("review-section"),
                          onVisibilityChanged: (info) {
                            if (info.visibleFraction > 0.1 &&
                                !reviewProvider.isLoading &&
                                reviewProvider.reviews.isEmpty &&
                                reviewProvider.errorMessage == null &&
                                !reviewProvider.hasFetchedReviews) {
                              reviewProvider.fetchReviews(widget.productID);
                            }
                          },
                          child: reviewProvider.isLoading
                              ? LoadingReviewCard()
                              : reviewProvider.reviews.isNotEmpty
                                  ? ReviewCard(
                                      review: reviewProvider.reviews.first)
                                  : reviewProvider.errorMessage != null
                                      ? Text(reviewProvider.errorMessage!)
                                      : Text('No reviews available.'),
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar:
          Consumer<CartProvider>(builder: (context, cartProvider, _) {
        return CustomBottomNavButton(
          onTap: () async {
            if (selectionProvider.selectedSize == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select a size first')),
              );
            } else {
              try {
                final response = await cartProvider.addToCart(
                    authProvider.loginId!,
                    productProvider.productID!,
                    selectionProvider.selectedSize!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(response)),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            }
          },
          title: 'Add to Cart',
          isLoading: cartProvider.isLoading,
        );
      }),
    );
  }
}
