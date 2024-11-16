import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingProductCard extends StatelessWidget {
  const LoadingProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: colorScheme.secondary.withOpacity(0.5),
          highlightColor: colorScheme.secondary.withOpacity(0.8),
          child: Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.secondary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(height: 12),
        Shimmer.fromColors(
          baseColor: colorScheme.secondary.withOpacity(0.5),
          highlightColor: colorScheme.secondary.withOpacity(0.8),
          child: Container(
            height: 16,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.secondary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        SizedBox(height: 4),
        Shimmer.fromColors(
          baseColor: colorScheme.secondary.withOpacity(0.5),
          highlightColor: colorScheme.secondary.withOpacity(0.8),
          child: Container(
            height: 16,
            width: 60,
            decoration: BoxDecoration(
              color: colorScheme.secondary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ],
    );
  }
}
