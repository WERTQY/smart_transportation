import 'package:flutter/material.dart';

class LocationTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final Color? prefixIconColor;
  final bool autoFocus;
  final FocusNode focusNode;

  const LocationTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.autoFocus,
    required this.focusNode,
    this.icon,
    this.prefixIconColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        //enableSuggestions: false,
        autofocus: autoFocus,
        focusNode: focusNode,
        controller: controller,
        onTap: () => controller.clear(),
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: icon,
            prefixIconColor: prefixIconColor,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}
