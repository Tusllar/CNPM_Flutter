import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../models/class_movie.dart';

class TitleMovie extends StatelessWidget {
  const TitleMovie({
    super.key,
    required this.movie2,
    required this.size,
  });

  final Movie2 movie2;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AutoSizeText(
          movie2.title ?? "No",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2, // Số dòng tối đa
          minFontSize: 15, // Cỡ chữ nhỏ nhất
        ),
        // SizedBox(height:),
        Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'ID: ${movie2.id}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.star, color: Colors.yellow, size: 15),
            const Icon(Icons.star, color: Colors.yellow, size: 15),
            const Icon(Icons.star, color: Colors.yellow, size: 15),
            const Icon(Icons.star, color: Colors.yellow, size: 15),
            const Icon(Icons.star_border, color: Colors.yellow, size: 15),
            const SizedBox(width: 8),
          ],
        ),
        Text(
          movie2.releaseDate ?? "No",
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: size.width - 40,
          child: Text(
            'Rating: ${movie2.rating}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
