import 'package:carousel_slider/carousel_slider.dart';
import 'package:dangnhap/views/InforMovie/ShowInfor.dart';
import 'package:flutter/material.dart';

import '../../../models/data.dart';

class Buildmoviestatic extends StatefulWidget {
  const Buildmoviestatic(
      {super.key, required this.popular, required this.size});
  final Future<List<Movie2>> popular;
  final Size size;
  @override
  State<Buildmoviestatic> createState() => _BuildmoviestaticState();
}

class _BuildmoviestaticState extends State<Buildmoviestatic> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return FutureBuilder<List<Movie2>>(
      future: widget.popular,
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              CarouselSlider(
                items: movies.map((movie) {
                  return GestureDetector(
                    onTap: () {
                      // Khi người dùng bấm vào, truyền index hiện tại vào MovieDetailPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Showinfor(movie2: movie),
                        ),
                      );
                    },
                    child: Container(
                      width: widget.size.width,
                      height: 150,
                      padding: const EdgeInsets.only(left: 10, bottom: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            movie.releaseDate ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  // autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 8,
                  viewportFraction: 0.5,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex =
                          index; // Cập nhật index hiện tại khi trang thay đổi
                    });
                  },
                ),
              ),
            ],
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
