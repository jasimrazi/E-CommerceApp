import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingCartCard extends StatelessWidget {
  const LoadingCartCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmering image placeholder with rounded corners
            Shimmer.fromColors(
              baseColor: colorScheme.secondary.withOpacity(0.5),
              highlightColor: colorScheme.secondary.withOpacity(0.8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
                child: Container(
                  height: 100.0.h,
                  width: 100.0.w,
                  color: colorScheme.secondary.withOpacity(0.5),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shimmering title placeholder with rounded corners
                  Shimmer.fromColors(
                    baseColor: colorScheme.secondary.withOpacity(0.5),
                    highlightColor: colorScheme.secondary.withOpacity(0.8),
                    child: Container(
                      height: 16.0.h,
                      width: 150.0.w,
                      decoration: BoxDecoration(
                        color: colorScheme.secondary.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.circular(4.0), // Rounded corners
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // Shimmering price placeholder with rounded corners
                  Shimmer.fromColors(
                    baseColor: colorScheme.secondary.withOpacity(0.5),
                    highlightColor: colorScheme.secondary.withOpacity(0.8),
                    child: Container(
                      height: 14.0.h,
                      width: 100.0.w,
                      decoration: BoxDecoration(
                        color: colorScheme.secondary.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.circular(4.0), // Rounded corners
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // Shimmering size placeholder with rounded corners
                  Shimmer.fromColors(
                    baseColor: colorScheme.secondary.withOpacity(0.5),
                    highlightColor: colorScheme.secondary.withOpacity(0.8),
                    child: Container(
                      height: 14.0.h,
                      width: 80.0.w,
                      decoration: BoxDecoration(
                        color: colorScheme.secondary.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.circular(4.0), // Rounded corners
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
