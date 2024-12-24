import 'package:flutter/material.dart';

class BuildText extends StatefulWidget {
  final String text;
  final Color color1;
  final Color color2;
  const BuildText(
      {required this.text,
      super.key,
      required this.color1,
      required this.color2});

  @override
  State<BuildText> createState() => _BuildTextState();
}

class _BuildTextState extends State<BuildText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [widget.color1, widget.color2], // Hai màu gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight, // Hướng gradient chéo
          ).createShader(bounds);
        },
        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Màu gốc để áp dụng Shader
          ),
        ),
      ),
    );
  }
}
