import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../models/class_movie.dart';
import '../../InforMovie/ShowInfor.dart';

class Buildmovie extends StatefulWidget {
  const Buildmovie({super.key, required this.popular, required this.size});
  final Future<List<Movie2>> popular;
  final Size size;

  @override
  State<Buildmovie> createState() => _BuildmovieState();
}

class _BuildmovieState extends State<Buildmovie> {
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
                    child: Stack(
                      children: [
                        Container(
                          width: widget.size.width,
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
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: const LinearGradient(
                              colors: [Colors.black12, Colors.black],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: widget.size.width,
                                padding:
                                    const EdgeInsets.only(bottom: 8, left: 8),
                                child: Text(
                                  movie.title ?? 'No Title',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Row(
                                        children: [
                                          // StarComponent(),
                                          // StarComponent(),
                                          // StarComponent(),
                                          // StarComponent(),
                                          // StarComponent(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
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
