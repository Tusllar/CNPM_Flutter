import 'dart:convert';

import 'package:dangnhap/models/data.dart';
import 'package:dangnhap/models/data1.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

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

  Future<List<Ticket>> ticketapp(int? id) async {
    const url = "http://192.168.1.4:80/getticket";
    // final dio = Dio();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({'id': id}),
      );
      // final response = await dio.get(link);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        print(jsonResponse);
        print('object');
        return jsonResponse.map((e) => Ticket.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }

  Future<void> removeBooking(int? ticket_id) async {
    const url = 'http://192.168.1.4:80/remove'; // Thay đổi địa chỉ IP phù hợp

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': ticket_id,
        }),
      );

      if (response.statusCode == 200) {
        print('Booking saved successfully!');
      } else {
        print('Failed to save booking. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  //nowplaying
  Future<List<Movie2>> Nowplay() async {
    const link = "http://192.168.1.4:80/nowplaying";
    final dio = Dio();
    final response = await dio.get(link);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;
      // print(jsonResponse);
      return jsonResponse.map((e) => Movie2.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie2>> Comming() async {
    const link = "http://192.168.1.4:80/commingsoon";
    final dio = Dio();
    final response = await dio.get(link);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;
      // print(jsonResponse);
      return jsonResponse.map((e) => Movie2.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Date>> getDate(int? id) async {
    const url = 'http://192.168.1.4:80/getdate';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({'id': id}),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((e) => Date.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }

  Future<List<Time>> getTime(int? scheduleId) async {
    if (scheduleId == null) {
      return []; // No time data if no schedule is selected
    }
    const url = 'http://192.168.1.4:80/gettime';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({'id': scheduleId}),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((e) => Time.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }

  Future<Seat> fetchSeats(int? time_id) async {
    // URL của API (thay thế với URL thực tế của bạn)
    const url = 'http://192.168.1.4:80/seat';
    // Gửi yêu cầu GET đến API
    // final response = await http.get(Uri.parse(url));
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({'id': time_id}),
      );

      // Kiểm tra xem yêu cầu có thành công không
      if (response.statusCode == 200) {
        // Phân tích JSON từ phản hồi
        List<dynamic> data = jsonDecode(response.body);
        // Giả sử rằng bạn chỉ cần lấy dữ liệu ghế từ item đầu tiên trong danh sách
        Map<String, dynamic> seatData =
            data[0]; // Lấy dữ liệu của ghế từ item đầu tiên
        // Chuyển đổi dữ liệu JSON thành đối tượng Seat
        return Seat.fromJson(seatData);
      } else {
        // Nếu yêu cầu không thành công, ném ra lỗi
        throw Exception('Failed to load seats');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }

  Future<int?> saveseat(int? time_id, String? seat_number) async {
    const url = 'http://192.168.1.4:80/saveseat'; // Thay đổi địa chỉ IP phù hợp

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'time_id': time_id,
          'seat_number': seat_number,
        }),
      );
      if (response.statusCode == 200) {
        print('Booking saved successfully!');
        print(jsonDecode(response.body));
        int data = jsonDecode(response.body);
        print(data);
        return data;
      } else {
        print('Failed to save booking. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return null;
  }

  ///saveticket
  Future<void> saveticket(int? user_id, int? seat_id, int? total_price) async {
    const url =
        'http://192.168.1.4:80/saveticket'; // Thay đổi địa chỉ IP phù hợp
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user_id': user_id,
          'seat_id': seat_id,
          'total_price': total_price,
        }),
      );
      if (response.statusCode == 200) {
        print('Booking saved successfully!');
      } else {
        print('Failed to save booking. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<List<Movie2>> SearchMovie(String query) async {
    final link = "http://192.168.1.4:80/search?q=$query";
    final dio = Dio();
    final response = await dio.get(link);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;
      // print(jsonResponse);
      return jsonResponse.map((e) => Movie2.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
//https://api.themoviedb.org/3/movie/popular/?api_key=0b82c1f970da5fef03e91e7c293dafbc
