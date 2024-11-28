import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final Color? prefixIconColor;
  final TextInputType keyboardType;
  final Function()? onTap;
  final bool readOnly;
  final bool canRequestFocus;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.readOnly = false,
    this.onTap,
    this.icon,
    this.prefixIconColor,
    this.keyboardType = TextInputType.text,
    this.canRequestFocus = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        canRequestFocus: canRequestFocus,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        //enableSuggestions: false,
        controller: controller,
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
