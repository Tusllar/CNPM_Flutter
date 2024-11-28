import 'package:dangnhap/views/SignupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Đăng Nhập",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: CupertinoColors.tertiarySystemBackground,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text("Đăng Ký"),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => SignupPage()),
            );
          },
        ),
      ),
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obs = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset(
                  "assets/images/key1.jpg",
                  scale: 0.8,
                ),
              ),
              CupertinoTextField(
                controller: emailController,
                placeholder: "Email",
                keyboardType: TextInputType.emailAddress,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
                clearButtonMode: OverlayVisibilityMode.editing,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: passwordController,
                placeholder: "Mật khẩu",
                obscureText: _obs,
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obs = !_obs;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      _obs ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                // const Icon(Icons.remove_red_eye),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 32),
              CupertinoButton(
                onPressed: () {
                  // Xử lý đăng nhập
                  print("Email: ${emailController.text}");
                  print("Mật khẩu: ${passwordController.text}");
                },
                color: CupertinoColors.label,
                child: const Text("Đăng Nhập"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
