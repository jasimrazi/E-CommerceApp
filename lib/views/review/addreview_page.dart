import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aami/viewmodels/product_provider.dart';
import 'package:aami/viewmodels/auth_provider.dart';
import 'package:aami/viewmodels/review_provider.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/bottomnavbutton.dart';
import 'package:aami/widgets/secondarytextfield.dart';
import 'package:aami/viewmodels/selection_provider.dart';

class AddReviewPage extends StatelessWidget {
  AddReviewPage({super.key});

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Add Review',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              SecondaryTextField(
                title: 'How was your experience?',
                hintText: 'Describe your experience',
                controller: commentController,
                isMultiline: true,
              ),
              SizedBox(height: 20.h),
              Text(
                'Rate your experience',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 10.h),
              Consumer<SelectionProvider>(
                builder: (context, selectionProvider, _) {
                  return Row(
                    children: [
                      Text(
                        selectionProvider.rating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Slider(
                            thumbColor: Theme.of(context).colorScheme.primary,
                            value: selectionProvider.rating,
                            min: 1.0,
                            max: 5.0,
                            divisions: 4,
                            onChanged: (newRating) {
                              selectionProvider.updateRating(newRating);
                            },
                            activeColor: Theme.of(context).colorScheme.surface,
                            inactiveColor:
                                Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      Text(
                        '5.0',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            Consumer<ReviewProvider>(builder: (context, reviewProvider, _) {
          return CustomBottomNavButton(
            onTap: () async {
              // Check if the comment field is empty
              if (commentController.text.isEmpty) {
                // Show error message if the comment field is empty
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('Please enter a comment before submitting')),
                );
                return; // Stop further execution
              }
              try {
                 // Convert rating to int before passing to postReview
                int ratingAsInt =
                    Provider.of<SelectionProvider>(context, listen: false)
                        .rating
                        .toInt();
                await reviewProvider.postReview(
                  productId: productProvider.productID!,
                  loginId: authProvider.loginId!,
                  rating: ratingAsInt,
                  comment: commentController.text,
                );
                
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            title: 'Submit Review',
            isLoading: reviewProvider.isLoading,
          );
        }),
      ),
    );
  }
}
