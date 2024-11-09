import 'package:aami/widgets/appbar.dart';
import 'package:aami/widgets/reviewcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllReviewPage extends StatelessWidget {
  AllReviewPage({super.key});

  // Sample list of reviews
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
    {
      "user_id": 2,
      "username": "John",
      "product_id": 1,
      "rating": 4,
      "comment": "Great quality!",
      "date_created": "2024-11-05T08:30:14.123456Z",
      "date_updated": "2024-11-05T09:00:10.654321Z"
    },
    // Add more reviews as needed
  ];

  @override
  Widget build(BuildContext context) {
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
                    '${reviews.length} Reviews',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Define action for the button (e.g., navigate to review page)
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
                child: ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return ReviewCard(review: reviews[index]);
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
