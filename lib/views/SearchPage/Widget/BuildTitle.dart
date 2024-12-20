import 'package:flutter/material.dart';

class BuildTitle extends StatelessWidget {
  const BuildTitle({
    super.key,
    required this.Title,
  });
  final String Title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Text(
        Title,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
