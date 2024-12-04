import 'package:dio/dio.dart';

import '../../models/data.dart';

class ApiService {
  Future<List<Movie>> Getdata() async {
    const link =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=0b82c1f970da5fef03e91e7c293dafbc";
    final dio = Dio();
    final response = await dio.get(link);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data['results'];
      // print(jsonResponse);
      return jsonResponse.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
