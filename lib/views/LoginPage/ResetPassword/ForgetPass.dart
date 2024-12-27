import 'package:flutter/material.dart';

import '../../../controller/APIservice/ApiLogin.dart';
import 'ResetPassword.dart';

class Forgetpass extends StatelessWidget {
  const Forgetpass({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    ApiLogin apiLogin = ApiLogin();
    return Scaffold(
      backgroundColor: const Color(0XFFE4EBE5),
      body: Stack(
        children: [
          // Hình ảnh làm nền
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/b.png'), // Đường dẫn hình ảnh
                fit: BoxFit.cover, // Phủ toàn màn hình
              ),
            ),
          ),
          // Nội dung phía trên hình nền
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 100),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 50),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/images/logup.png',
                      height: 100,
                      width: 300,
                    ),
                  ),
                  // const SizedBox(height: 50),
                  const Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Go Back To',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white, // Màu nền ô nhập
                        hintText: "ex@email.com",
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: const Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        );
                        try {
                          final resuft =
                              await apiLogin.checkEmail(emailController.text);
                          Navigator.pop(context);
                          if (resuft == 200) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Resetpassword(
                                        email: emailController.text)));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text(
                                      'Email không tồn tại',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyanAccent),
                                    ),
                                    content: Text('Vui lòng nhập lại email'),
                                  );
                                });
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text(
                                  'Lỗi kết nối',
                                  style: TextStyle(color: Colors.black),
                                ),
                                content: Text(
                                  'Không thể kết nối: $e',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF0077FF),
                          minimumSize: const Size(250, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text(
                        "Get Email",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
