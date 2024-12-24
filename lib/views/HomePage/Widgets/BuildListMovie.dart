import 'package:flutter/material.dart';

import '../../../models/class_movie.dart';
import '../../SearchPage/Widget/ListMovie.dart';

class BuildListMovie extends StatelessWidget {
  const BuildListMovie({
    super.key,
    required this.size,
    required this.movie,
    required this.movie1,
  });

  final Size size;
  final Future<List<Movie2>> movie;
  final Future<List<Movie2>> movie1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DefaultTabController(
        length: 3, // Số lượng tab
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: "For You"),
                Tab(text: "Popular"),
                // Tab(text: "Trending"),
              ],
              indicatorColor: Colors.cyanAccent,
              unselectedLabelColor: Colors.white,
              labelColor: Colors.cyanAccent,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              indicator: null,
            ),
            SizedBox(
              height: 160,
              width: size.width, // Đặt chiều cao cho TabBarView
              child: TabBarView(
                children: [
                  ListMovie(movie: movie1),
                  ListMovie(movie: movie),
                  // ListMovie(movie: movie1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
