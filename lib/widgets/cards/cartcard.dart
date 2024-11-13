import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> images;
  final String size; // Added size field
  final int quantity; // Quantity handled by provider
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove; // Add remove callback to handle item removal

  const CartCard({
    Key? key,
    required this.title,
    required this.price,
    required this.images,
    required this.size, // Initialize size
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove, // Initialize remove callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the first image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                images.isNotEmpty ? images[0] : '',
                height: 100.0.h, // Adjust height to match card height
                width: 100.0.w,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\$ $price',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Size: $size', // Display size
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity control buttons
                      Row(
                        children: [
                          IconButton(
                            onPressed: onDecrease,
                            icon: Icon(Icons.keyboard_arrow_down),
                          ),
                          Text(
                            '$quantity',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          IconButton(
                            onPressed: onIncrease,
                            icon: Icon(Icons.keyboard_arrow_up),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: onRemove, // Handle remove action
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
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
