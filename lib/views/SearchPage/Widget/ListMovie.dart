import 'package:flutter/material.dart';

import '../../../models/class_movie.dart';
import '../../InforMovie/ShowInfor.dart';

class ListMovie extends StatelessWidget {
  const ListMovie({
    super.key,
    required this.movie,
  });

  final Future<List<Movie2>> movie;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie2>>(
      future: movie,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final movies = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            child: Row(
              children: List.generate(movies.length, (index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Showinfor(movie2: movie),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: Container(
                      width: 100,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            movie.posterPath != null &&
                                    movie.posterPath!.isNotEmpty
                                ? '${movie.posterPath}'
                                : 'https://yourdefaultimageurl.com/default.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        } else {
          return const Center(
            child: Text('No data found'),
          );
        }
      },
    );
  }
}
