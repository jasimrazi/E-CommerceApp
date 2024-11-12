import 'package:aami/models/review_model.dart';
import 'package:aami/utils/datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: Icon(
                Icons.person_outline,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.username,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 12,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      formatDate(review.dateCreated),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: index < review.rating
                      ? Color(0xffFF981F)
                      : Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5),
                  size: 15.sp,
                );
              }),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        ReadMoreText(
          review.comment,
          trimMode: TrimMode.Line,
          trimLines: 2,
          colorClickableText: Theme.of(context).colorScheme.primary,
          trimCollapsedText: ' Show more',
          trimExpandedText: ' Show less',
          style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .secondary), // Explicitly setting color to the bodySmall color in the theme
          moreStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }
}
