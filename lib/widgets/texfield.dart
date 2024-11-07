import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final Color? fillColor;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.icon,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          hintText: hintText,
          icon: icon != null ? Icon(icon) : null,
          filled: fillColor != null,
          fillColor: fillColor,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 1.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 1.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0), // Add vertical padding
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
