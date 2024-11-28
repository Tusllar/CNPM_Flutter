import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinalInfoPage extends StatelessWidget {
  final String username;
  final String email;
  final String phone;
  final String address;

  FinalInfoPage({
    super.key,
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
  });
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    phoneController.text = phone;
    addressController.text = address;
    usernameController.text = username;
    emailController.text = email;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Thông Tin Hoàn Tất",
          style: TextStyle(fontSize: 25),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Thông Tin",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Icon(
                  Icons.supervised_user_circle,
                  size: 100,
                ),
                const SizedBox(height: 16),
                CupertinoTextField(
                  controller: usernameController,
                  readOnly: true,
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
                  readOnly: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoTextField(
                  controller: phoneController,
                  readOnly: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 16),
                CupertinoTextField(
                  controller: addressController,
                  readOnly: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 32),
                CupertinoButton.filled(
                  onPressed: () {
                    // Xử lý hoặc quay về trang chính
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text("Quay Lại Trang Đăng Nhập"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
