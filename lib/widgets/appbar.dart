import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isCart;

  // Constructor to allow customization based on condition
  const CustomAppbar({
    Key? key,
    this.isCart = false,
  }) : super(key: key);

  // Implement the preferredSize property required by PreferredSizeWidget
  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Default app bar height

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: AppBar(
        leading: Transform.scale(
          scale: 0.8,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
          ),
        ),
        actions: isCart
            ? [
                Transform.scale(
                  scale: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          // Define cart action here
                        },
                        icon: Icon(Icons.shopping_bag_outlined),
                      ),
                    ),
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
