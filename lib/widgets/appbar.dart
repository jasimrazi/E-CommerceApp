import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;

  // Constructor to allow customization
  const CustomAppbar({
    Key? key,
    this.actions = const [],
  }) : super(key: key);

  // Implement the preferredSize property required by PreferredSizeWidget
  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Default app bar height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.arrow_back)),
      ),
      actions: actions,
    );
  }
}
