import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageCard extends StatelessWidget {
  final String image;

  const ImageCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75
          .w, // Setting both width and height to the same value for a square shape
      height: 75.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          image,
          fit: BoxFit.cover, // Ensures the image covers the container
          width: 75.w,
          height: 75.h,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.broken_image, size: 50);
          },
        ),
      ),
    );
  }
}
