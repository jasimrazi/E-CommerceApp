import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageCard extends StatelessWidget {
  final String image;
  final bool isSelected;

  const ImageCard({super.key, required this.image, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.w,
      height: 75.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: isSelected
            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            : null, // Add a primary color border if selected
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          image,
          fit: BoxFit.cover,
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
