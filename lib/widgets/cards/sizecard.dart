import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeCard extends StatelessWidget {
  final String size;
  const SizeCard({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50
          .w, // Setting both width and height to the same value for a square shape
      height: 50.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Text(
              size,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )),
    );
  }
}
