import 'package:dangnhap/views/BottomNavBar.dart';
import 'package:flutter/material.dart';

import 'Widget/LoginForm.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFFE4EBE5),
        appBar: AppBar(
          backgroundColor: const Color(0XFFE4EBE5),
          title: const Text(
            "Back",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          leading: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavBar()));
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                size: 30,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              LoginForm(),
            ],
          ),
        ));
  }
}
