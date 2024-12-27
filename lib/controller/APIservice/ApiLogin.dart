import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Storage.dart';

final Storage s = Storage();

class ApiLogin {
  Future<String> Signup(String? username, String? email, String? pass) async {
    const url = 'http://10.10.31.49:80/signup';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({'user': username, 'email': email, 'password': pass}),
      );
      if (response.statusCode == 200) {
        print('Booking saved successfully!');
        print('${response.body}');
        return '200';
      } else if (response.statusCode == 400) {
        print('Failed to save booking. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
        return '400';
      } else {
        print('Failed to save booking. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
        return '409';
      }
    } catch (e) {
      // throw Exception('Connection error: $e');
      print(e);
      return '500';
    }
  }

  Future<String> Signin(String? email, String? pass) async {
    const url = 'http://10.10.31.49:80/signin';
    // const s = FlutterSecureStorage();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({'email': email, 'password': pass}),
      );
      if (response.statusCode == 200) {
        print('Loggin sucessfull!');
        print(json.decode(response.body));
        var data = json.decode(response.body);
        if (data.containsKey('user')) {
          var user = data['user'];
          // Lấy các thông tin của người dùng từ dữ liệu trả về
          int userId = user['id'];
          String fullname = user['fullname'];
          String userEmail = user['email'];
          String password =
              user['password']; // Lưu ý không nên gửi mật khẩu trực tiếp ở đây
          print('ID người dùng: $userId');
          print('Tên người dùng: $fullname');
          print('Email người dùng: $userEmail');
          s.saveUserData(userId, userEmail, fullname, password);
        }
        return '200';
      } else if (response.statusCode == 401) {
        print('Invalid PW. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
        return '401';
      } else {
        print('Failed to save booking. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
        return '404';
      }
    } catch (e) {
      // throw Exception('Connection error: $e');
      print(e);
      return '500';
    }
  }

  // Future<String> getInfor(String? email, String? pass) async {
  //   const url = 'http://192.168.1.4:80/signin';
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {'Content-Type': 'application/json; charset=UTF-8'},
  //       body: json.encode({'email': email, 'password': pass}),
  //     );
  //     if (response.statusCode == 200) {
  //       print('Loggin sucessfull!');
  //       return '200';
  //     } else if (response.statusCode == 401) {
  //       print('Invalid PW. Status code: ${response.statusCode}');
  //       print('Response: ${response.body}');
  //       return '401';
  //     } else {
  //       print('Failed to save booking. Status code: ${response.statusCode}');
  //       print('Response: ${response.body}');
  //       return '404';
  //     }
  //   } catch (e) {
  //     // throw Exception('Connection error: $e');
  //     print(e);
  //     return '500';
  //   }
  // }

  Future<int> checkEmail(String email) async {
    const url = 'http://10.10.31.49:80/checkmail';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json;charset=UTF-8'},
          body: json.encode({'email': email}));
      if (response.statusCode == 200) {
        print('check có');
        return 200;
      }
    } catch (e) {
      throw Exception('Failed to load movies');
    }
    return 0;
  }

  Future<int> resetpass(String email, String? pass) async {
    const url = 'http://10.10.31.49:80/resetpass';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json;charset=UTF-8'},
          body: json.encode({'email': email, 'password': pass}));
      if (response.statusCode == 200) {
        print('check có');
        return 200;
      }
    } catch (e) {
      throw Exception('Failed to load movies');
    }
    return 0;
  }
}
