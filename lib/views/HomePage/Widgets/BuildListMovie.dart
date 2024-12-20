import 'package:flutter/material.dart';

import '../../../models/data.dart';
import '../../SearchPage/Widget/ListMovie.dart';

class BuildListMovie extends StatelessWidget {
  const BuildListMovie({
    super.key,
    required this.size,
    required this.movie,
  });

  final Size size;
  final Future<List<Movie2>> movie;

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
                Tab(text: "Trending"),
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
                  FutureBuilder<List<Movie2>>(
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
                              margin: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(movie.title ?? "No"),
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
                  FutureBuilder<List<Movie2>>(
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
                              margin: const EdgeInsets.all(15.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No data'));
                      }
                    },
                  ),
                  ListMovie(movie: movie),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
