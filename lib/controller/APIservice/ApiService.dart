import 'package:dio/dio.dart';

import '../../models/data.dart';

class ApiService {
  Future<List<Movie2>> Popular() async {
    const link =
        "https://api.themoviedb.org/3/movie/popular?api_key=0b82c1f970da5fef03e91e7c293dafbc";
    final dio = Dio();
    final response = await dio.get(link);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data['results'];
      // print(jsonResponse);
      return jsonResponse.map((e) => Movie2.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie2>> fetchMovies() async {
    const link =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=0b82c1f970da5fef03e91e7c293dafbc";
    final dio = Dio();
    final response = await dio.get(link);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data['results'];
      return jsonResponse.map((e) => Movie2.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie2>> Upcoming() async {
    const link =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=0b82c1f970da5fef03e91e7c293dafbc";
    final dio = Dio();
    final response = await dio.get(link);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data['results'];
      return jsonResponse.map((e) => Movie2.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie2>> Toprate() async {
    const link =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=0b82c1f970da5fef03e91e7c293dafbc";
    final dio = Dio();
    final response = await dio.get(link);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data['results'];
      return jsonResponse.map((e) => Movie2.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Ticket>> ticketapp() async {
    const link = "http://192.168.1.4:80/get";
    final dio = Dio();
    final response = await dio.get(link);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;
      return jsonResponse.map((e) => Ticket.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Ticket>> removeticketapp() async {
    const link = "http://192.168.1.4:80/remove";
    final dio = Dio();
    final response = await dio.get(link);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;
      return jsonResponse.map((e) => Ticket.fromJson(e)).toList();
    } else {
      throw Exception('Failed to remove movies');
    }
  }
}
//https://api.themoviedb.org/3/movie/popular/?api_key=0b82c1f970da5fef03e91e7c293dafbc
