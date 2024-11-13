import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeCard extends StatelessWidget {
  final String size;
  final bool isSelected;

  const SizeCard({
    super.key,
    required this.size,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w, // Square shape
      height: 50.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          width: isSelected ? 2.0 : 1.0,
        ),
      ),
      child: Center(
        child: Text(
          size,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
