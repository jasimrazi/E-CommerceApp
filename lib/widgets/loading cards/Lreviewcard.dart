import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingReviewCard extends StatelessWidget {
  const LoadingReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Row(
          children: [
            // Shimmering Circle Avatar
            Shimmer.fromColors(
              baseColor: colorScheme.secondary.withOpacity(0.5),
              highlightColor: colorScheme.secondary.withOpacity(0.8),
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: colorScheme.secondary.withOpacity(0.5),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmering Name Placeholder
                Shimmer.fromColors(
                  baseColor: colorScheme.secondary.withOpacity(0.5),
                  highlightColor: colorScheme.secondary.withOpacity(0.8),
                  child: Container(
                    height: 14.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                // Shimmering Date Placeholder
                Shimmer.fromColors(
                  baseColor: colorScheme.secondary.withOpacity(0.5),
                  highlightColor: colorScheme.secondary.withOpacity(0.8),
                  child: Container(
                    height: 12.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: List.generate(5, (index) {
                return Shimmer.fromColors(
                  baseColor: colorScheme.secondary.withOpacity(0.5),
                  highlightColor: colorScheme.secondary.withOpacity(0.8),
                  child: Icon(
                    Icons.star,
                    color: colorScheme.secondary.withOpacity(0.5),
                    size: 15.sp,
                  ),
                );
              }),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        // Shimmering Review Text Placeholder
        Shimmer.fromColors(
          baseColor: colorScheme.secondary.withOpacity(0.5),
          highlightColor: colorScheme.secondary.withOpacity(0.8),
          child: Container(
            height: 40.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.secondary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
