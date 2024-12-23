import 'package:dangnhap/controller/APIservice/ApiLogin.dart';
import 'package:dangnhap/views/LoginPage/SignIn/LoginPage.dart';
import 'package:flutter/material.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({super.key, required this.email});
  final String email;

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  @override
  Widget build(BuildContext context) {
    ApiLogin apiLogin = ApiLogin();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController comfirmpasswordController =
        TextEditingController();
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
                    'Reset \nPassword',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Fill in the form and create and account.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffA7CEAB),
                      labelText: "Password",
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 15),
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.blue), // Màu viền khi focus
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: comfirmpasswordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffA7CEAB),
                      labelText: "Confirm Password",
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 15),
                      hintText: "Confirm password",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.blue), // Màu viền khi focus
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
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
                        if (passwordController.text.isNotEmpty &&
                            comfirmpasswordController.text.isNotEmpty) {
                          if (passwordController.text ==
                              comfirmpasswordController.text) {
                            try {
                              Navigator.pop(context);
                              final resuft = await apiLogin.resetpass(
                                  widget.email, passwordController.text);
                              if (resuft == 200) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text(
                                          'Cập nhật mật khẩu thành công',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        content: const Text(
                                          'Tiếp tục đăng nhập',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage()));
                                              },
                                              child: const Text(
                                                'Go To Login',
                                              ))
                                        ],
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
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  );
                                },
                              );
                            }
                          } else {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    title: Text('Mật khẩu không khớp'),
                                    content: Text('Kiểm tra lại mật khẩu'),
                                  );
                                });
                          }
                        } else {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text('Vui lòng nhập mật khẩu '),
                                );
                              });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF0077FF),
                        minimumSize: const Size(300, 50),
                      ),
                      child: const Text(
                        "Reset Password",
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
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
