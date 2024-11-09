import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isCart;
  final String? title; // Optional title parameter

  const CustomAppbar({
    Key? key,
    this.isCart = false,
    this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ),
        title: title != null
            ? Text(
                title!,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            : null,
        centerTitle: true, // Center the title
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
        backgroundColor:
            Colors.transparent, // Make the app bar background transparent
        elevation: 0, // Remove the shadow
      ),
    );
  }
}
