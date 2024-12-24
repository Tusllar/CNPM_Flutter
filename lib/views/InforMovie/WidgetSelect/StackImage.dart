import 'package:dangnhap/views/InforMovie/WidgetSelect/TitleMovie.dart';
import 'package:dangnhap/views/SetPerson/Widget/ButtomPop.dart';
import 'package:flutter/material.dart';

import '../../../models/class_movie.dart';

class StackImage extends StatelessWidget {
  const StackImage({
    super.key,
    required this.movie2,
    required this.size,
  });
  final Movie2 movie2;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Image.network(
            movie2.backdropPath ?? "NO",
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
          ),
        ),
        Container(
          height: 300,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black12, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Buttompop(),
              SizedBox(height: size.height / 5),
              // TitleMovie(widget: movie2, size: size)
              TitleMovie(movie2: movie2, size: size),
            ],
          ),
        ),
      ],
    );
  }
}
