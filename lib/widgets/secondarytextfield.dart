import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryTextField extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isMultiline; // New parameter

  const SecondaryTextField({
    Key? key,
    required this.title,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.isMultiline = false, // Default is single-line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 10.h),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: isMultiline ? 100.h : 0, // Expands when multiline
          ),
          child: TextField(
            controller: controller,
            keyboardType: isMultiline ? TextInputType.multiline : keyboardType,
            obscureText: obscureText,
            maxLines: isMultiline ? 5 : null, // Allows multiline if true
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14.0,
                horizontal: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
