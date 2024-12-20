import 'package:flutter/material.dart';

import '../../../models/data.dart';

class BuildUpcoming extends StatelessWidget {
  const BuildUpcoming({
    super.key,
    required this.size,
    required this.movie,
  });

  final Size size;
  final Future<List<Movie2>> movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: size.width,
      child: FutureBuilder<List<Movie2>>(
        future: movie,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          fit: BoxFit.cover,
                          height: 120,
                          width: 120,
                        ),
                      ),
                      Text(
                        movie.title ?? " no",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        movie.releaseDate ?? " no",
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
