import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../controller/APIservice/ApiService.dart';
import '../../models/data.dart';
import 'Widget/BuildTitle.dart';
import 'Widget/ListMovie.dart';

class Homesearch extends StatefulWidget {
  const Homesearch({
    super.key,
  });

  @override
  State<Homesearch> createState() => _HomesearchState();
}

class _HomesearchState extends State<Homesearch> {
  late Future<List<Movie2>> movie;
  late Future<List<Movie2>> popular;
  late Future<List<Movie2>> upcoming;
  late Future<List<Movie2>> toprate;
  ApiService fetmovie = ApiService();

  @override
  void initState() {
    super.initState();
    movie = fetmovie.fetchMovies();
    popular = fetmovie.Popular();
    upcoming = fetmovie.Upcoming();
    toprate = fetmovie.Toprate();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 100, left: 20, right: 20, bottom: 10),
            child: SizedBox(
              child: Row(children: [
                Expanded(
                    child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: DarkTheme.colorSearch,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Icon(
                          Icons.saved_search,
                          color: DarkTheme.white,
                        ),
                      ),
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Movie',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.mic,
                          color: DarkTheme.white,
                        ),
                      ),
                    ],
                  ),
                )),
              ]),
            ),
          ),
          const BuildTitle(Title: "Now Playing"),
          ListMovie(movie: movie),
          const BuildTitle(Title: "Coming Soon"),
          ListMovie(movie: toprate),
          const BuildTitle(Title: "Top Movies"),
          ListMovie(movie: upcoming),
          const BuildTitle(Title: "Now Playing"),
          ListMovie(movie: movie),
        ],
      ),
    );
  }
}
