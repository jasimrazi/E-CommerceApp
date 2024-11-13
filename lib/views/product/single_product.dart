import 'package:aami/viewmodels/product_provider.dart';
import 'package:aami/viewmodels/review_provider.dart';
import 'package:aami/views/review/allreview_page.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/cards/imagecard.dart';
import 'package:aami/widgets/cards/reviewcard.dart';
import 'package:aami/widgets/cards/sizecard.dart';
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

    // Fetch the single product and reset reviews when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      final reviewProvider =
          Provider.of<ReviewProvider>(context, listen: false);

      productProvider.fetchSingleProduct(widget.productID);
      reviewProvider.clearReviews(); // Clear previous reviews
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
    final product = productProvider.product;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(isCart: true),
      body: productProvider.isLoading
          ? Center(
              child:
                  Scaffold(body: Center(child: CupertinoActivityIndicator())))
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
                        Container(
                          width: double.maxFinite,
                          height: 400.h,
                          child: Image.network(
                            product.images[0],
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
                        SizedBox(
                          height: 75.h,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: product.images.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ImageCard(image: product.images[index]),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
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
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SizeCard(size: product.sizes[index]),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text('Description',
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(height: 10.h),
                        ReadMoreText(
                          product.description,
                          trimMode: TrimMode.Line,
                          trimLines: 2,
                          colorClickableText:
                              Theme.of(context).colorScheme.primary,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
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
                              ? Center(child: CupertinoActivityIndicator())
                              : reviewProvider.reviews.isNotEmpty
                                  ? ReviewCard(
                                      review: reviewProvider.reviews
                                          .first) // Or display all reviews in a list
                                  : reviewProvider.errorMessage != null
                                      ? Text(reviewProvider.errorMessage!)
                                      : Text('No reviews available.'),
                        ),


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
