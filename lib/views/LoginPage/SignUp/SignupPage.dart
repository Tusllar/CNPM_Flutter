import 'package:dangnhap/views/BottomNavBar.dart';
import 'package:flutter/material.dart';

import 'Widget/SignupForm.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE4EBE5),
      appBar: AppBar(
        backgroundColor: const Color(0XFFE4EBE5),
        title: const Text(
          "Login",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavBar()),
                );
              },
              child: const Icon(
                Icons.home_filled,
                size: 30,
                color: Colors.black,
              )),
        ],
      ),
      body: SignupForm(),
    );
  }
}
