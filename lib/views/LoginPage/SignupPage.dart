import 'package:dangnhap/views/LoginPage/AdditionalInforPage.dart';
import 'package:flutter/cupertino.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Đăng Ký",
          style: TextStyle(fontSize: 25),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: SignupForm(),
    );
  }
}

class SignupForm extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                width: 250,
                height: 250,
                child: Image.asset(
                  "assets/images/key1.jpg",
                  scale: 0.8,
                ),
              ),
              CupertinoTextField(
                controller: usernameController,
                placeholder: "Tên người dùng",
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 16),
              CupertinoTextField(
                controller: emailController,
                placeholder: "Email",
                keyboardType: TextInputType.emailAddress,
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
                obscureText: true,
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
                  // Chuyển đến màn hình thông tin bổ sung
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AdditionalInfoPage(
                        username: usernameController.text,
                        email: emailController.text,
                      ),
                    ),
                  );
                },
                color: CupertinoColors.label,
                child: const Text("Đăng Ký"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
