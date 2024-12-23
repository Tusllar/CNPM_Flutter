import 'package:flutter/material.dart';

import '../../../models/data.dart';
import '../../InforMovie/ShowInfor.dart';

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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Showinfor(movie2: movie),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            '${movie.posterPath}',
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        child: Flexible(
                          child: Text(
                            movie.title ?? "no",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow:
                                TextOverflow.ellipsis, // Xử lý văn bản dài
                            maxLines: 1, // Giới hạn chỉ 1 dòng
                          ),
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
