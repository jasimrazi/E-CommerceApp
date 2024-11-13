import 'package:aami/viewmodels/review_provider.dart';
import 'package:aami/views/review/addreview_page.dart';
import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/cards/reviewcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllReviewPage extends StatelessWidget {
  AllReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Reviews',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${reviewProvider.reviews.length} Reviews',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Define action for the button (e.g., navigate to review page)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddReviewPage(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Color(0xffFF7043), // Set background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Set rounded corners
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0), // Padding inside the button
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Add a review',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.0), // Add space between the row and the list
              Expanded(
                child: reviewProvider.isLoading ? Center(child: CupertinoActivityIndicator()) : ListView.builder(
                  itemCount: reviewProvider.reviews.length,
                  itemBuilder: (context, index) {
                    return ReviewCard(review: reviewProvider.reviews[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
