import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onSearch;
  final Function(String)? onChanged;

  const CustomSearchBar({
    Key? key,
    this.controller,
    this.onSearch,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.5);
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    final backgroundColor = Theme.of(context).colorScheme.surface;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        onSubmitted: onSearch,
        onChanged: onChanged,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: iconColor),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: iconColor),
        ),
      ),
    );
  }
}
