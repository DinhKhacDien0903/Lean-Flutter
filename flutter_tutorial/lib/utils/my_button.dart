import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String displayText;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const MyButton({
    super.key,
    required this.displayText,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
      child: Text(displayText, style: TextStyle(color: textColor)),
    );
  }
}
