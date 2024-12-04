import 'package:carousel_slider/carousel_slider.dart';
import 'package:dangnhap/models/data.dart';
import 'package:dangnhap/views/HomePage/Nowplaying/tets.dart';
import 'package:flutter/material.dart';

class Nowplaying extends StatefulWidget {
  const Nowplaying(
      {super.key,
      required this.data1,
      required this.headlineText,
      required this.size});
  final Future<List<Movie>> data1;
  final String headlineText;
  final Size size;
  @override
  State<Nowplaying> createState() => _NowplayingState();
}

class _NowplayingState extends State<Nowplaying> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
        future: widget.data1,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies found'));
          }
          List<Movie> movies = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                child: Text(
                  widget.headlineText,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
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
                          builder: (context) => const Moviedetailpage(),
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
                                movie.posterPath,
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
                                  movie.title,
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
        });
  }
}
