import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../views/LoginPage/SignIn/LoginPage.dart';

class Storage {
  static const storage = FlutterSecureStorage();
  Future<void> saveUserData(
      int id, String email, String name, String pass) async {
    await storage.write(key: 'id', value: id.toString());
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'pass', value: pass);
    await storage.write(key: 'name', value: name);
  }

  Future<void> logout(context) async {
    await storage.deleteAll();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  // Future<void> _loadUserData(String? userName, int? user_id, String? userEmail,
  //     bool isLoggedIn) async {
  //   // Lấy dữ liệu người dùng từ FlutterSecureStorage
  //   String? id = await storage.read(key: 'id');
  //   String? name = await storage.read(key: 'name');
  //   String? email = await storage.read(key: 'email');
  //   setState(() {
  //     userName = name ?? "Guest";
  //     userEmail = email ?? "guest@example.com";
  //     user_id = id != null ? int.tryParse(id) : null;
  //     isLoggedIn = user_id != null &&
  //         userName != "Guest" &&
  //         userEmail != "guest@example.com";
  //   });
  // }

  Future<void> loadUserData(
      Function(String?, String?, int?, bool) onUserDataLoaded) async {
    String? id = await storage.read(key: 'id');
    String? name = await storage.read(key: 'name');
    String? email = await storage.read(key: 'email');

    bool isLoggedIn = id != null && name != null && email != null;

    onUserDataLoaded(
        name, email, id != null ? int.tryParse(id) : null, isLoggedIn);
  }
}
