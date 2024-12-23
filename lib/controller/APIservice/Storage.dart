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
    print('save');
  }

  Future<void> logout(context) async {
    // Xóa dữ liệu người dùng khi đăng xuất
    await storage.deleteAll();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
