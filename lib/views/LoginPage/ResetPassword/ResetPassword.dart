import 'package:flutter/material.dart';

import '../../../controller/APIservice/ApiLogin.dart';
import '../SignIn/LoginPage.dart';

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
      // backgroundColor: const Color(0XFFE4EBE5),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Hình ảnh làm nền
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/b.png'), // Đường dẫn hình ảnh
                  fit: BoxFit.cover, // Phủ toàn màn hình
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Center(
                  child: Container(
                    height: 500,
                    width: 320,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            // Nội dung phía trên hình nền
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
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
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: passwordController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Password",
                          labelStyle: const TextStyle(
                              color: Colors.black, fontSize: 15),
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blue), // Màu viền khi focus
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        controller: comfirmpasswordController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Confirm Password",
                          labelStyle: const TextStyle(
                              color: Colors.black, fontSize: 15),
                          hintText: "Confirm password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blue), // Màu viền khi focus
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          // Kiểm tra mật khẩu phải dài hơn 8 ký tự và chứa cả chữ và số
                          String password = passwordController.text;
                          RegExp passwordRegExp =
                              RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{8,}$');

                          if (!passwordRegExp.hasMatch(password)) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    'Invalid Password',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  content: Text(
                                    'Password must be at least 8 characters long and include both letters and numbers.',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              },
                            );
                            return;
                          }
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
                                            style:
                                                TextStyle(color: Colors.black),
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
                                        style: const TextStyle(
                                            color: Colors.black),
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
                            minimumSize: const Size(250, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: const Text(
                          "Reset Password",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
