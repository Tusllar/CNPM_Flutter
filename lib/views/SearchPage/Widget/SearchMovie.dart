import 'package:dangnhap/controller/APIservice/ApiService.dart';
import 'package:flutter/material.dart';

import '../../../models/data.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({
    super.key,
  });

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  ApiService apiService = ApiService();
  late Future<List<Movie2>> movie;
  bool key = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
// const SizedBox(height: 20),
// if (key) ...[
// ListMovie(movie: movie),]
