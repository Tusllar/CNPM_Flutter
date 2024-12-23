import 'package:dangnhap/controller/APIservice/ApiLogin.dart';
import 'package:dangnhap/views/LoginPage/ResetPassword/ResetPassword.dart';
import 'package:flutter/material.dart';

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
                image: AssetImage('assets/images/ii.png'), // Đường dẫn hình ảnh
                fit: BoxFit.cover, // Phủ toàn màn hình
              ),
            ),
          ),
          // Nội dung phía trên hình nền
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_outlined),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Forgot \nPassword',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Insert your login E-mail and get a forgot \npassword request.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffA7CEAB)
                          .withOpacity(0.8), // Màu nền ô nhập
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.black),
                      hintText: "ex@email.com",
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: const Icon(Icons.email),
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
                        minimumSize: const Size(300, 50),
                      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Go Back To',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
