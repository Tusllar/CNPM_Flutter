import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Define Movie1 model
class Movie1 {
  final String title;
  final String releaseDate;
  final String posterPath;

  Movie1({
    required this.title,
    required this.releaseDate,
    required this.posterPath,
  });

  factory Movie1.fromJson(Map<String, dynamic> json) {
    return Movie1(
      title: json['title'],
      releaseDate: "https://image.tmdb.org/t/p/w500" + json['release_date'],
      posterPath: "https://image.tmdb.org/t/p/w500" + json['poster_path'],
    );
  }
}

// https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg
// Fetch data from the API
Future<List<Movie1>> fetchMovies() async {
  const link =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=0b82c1f970da5fef03e91e7c293dafbc";
  final dio = Dio();
  final response = await dio.get(link);

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = response.data['results'];
    return jsonResponse.map((e) => Movie1.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

// Main StatefulWidget
class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  late Future<List<Movie1>> data;

  @override
  void initState() {
    super.initState();
    data = fetchMovies(); // Call the API function
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int _currentIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
      ),
      body: FutureBuilder<List<Movie1>>(
        future: data,
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
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: size.width,
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(movie.posterPath),
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
                                  width: size.width,
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
          } else {
            return const Center(
              child: Text('No data found'),
            );
          }
        },
      ),
    );
  }
}
