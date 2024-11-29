import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color borderColor;
  final IconData arrowIcon;

  const ProfileButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.arrowIcon = Icons.arrow_forward,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black, // Adjust border color
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              arrowIcon,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}