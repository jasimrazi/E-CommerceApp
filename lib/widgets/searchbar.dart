import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onSearch;
  final Function(String)? onChanged;
  final bool isLoading;

  const CustomSearchBar({
    Key? key,
    this.controller,
    this.onSearch,
    this.onChanged,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.5);
    final backgroundColor = Theme.of(context).colorScheme.surface;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: iconColor),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSearch,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintText: 'Search...',
                hintStyle: TextStyle(color: iconColor),
                border: InputBorder.none,
              ),
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CupertinoActivityIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
