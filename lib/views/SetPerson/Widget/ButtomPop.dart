import 'package:flutter/material.dart';

class Buttompop extends StatelessWidget {
  const Buttompop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Quay lại màn hình trước đó
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
