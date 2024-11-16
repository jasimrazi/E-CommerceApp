import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingAddressCard extends StatelessWidget {
  const LoadingAddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Shimmer.fromColors(
      baseColor: colorScheme.secondary.withOpacity(0.5),
      highlightColor: colorScheme.secondary.withOpacity(0.8),
      child: Row(
        children: [
          // Placeholder for the Icon
          Container(
            height: 56.h,
            width: 56.h,
            decoration: BoxDecoration(
              color: colorScheme.secondary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          SizedBox(width: 20.w),
          // Placeholder for text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder for Address
              Container(
                height: 16.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(height: 8.0),
              // Placeholder for City
              Container(
                height: 12.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
