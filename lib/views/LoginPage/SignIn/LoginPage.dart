import 'package:flutter/material.dart';

import 'LoginForm.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF191B2C),
        body: SingleChildScrollView(
          child: Column(
            children: [
              LoginForm(),
            ],
          ),
        ));
  }
}
