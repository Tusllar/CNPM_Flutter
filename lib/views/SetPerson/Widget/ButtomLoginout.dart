import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;

  const ActionButton({
    Key? key,
    required this.buttonText,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
