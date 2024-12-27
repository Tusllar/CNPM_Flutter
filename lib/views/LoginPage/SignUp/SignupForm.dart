import 'package:flutter/material.dart';

import '../../../controller/APIservice/ApiLogin.dart';
import '../SignIn/LoginPage.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final ApiLogin apiLogin = ApiLogin();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Stack(
                children: [
                  Container(
                    height: 800,
                    width: 600,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_outlined,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Have an Account ?',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => LoginPage()));
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: BuildTextField(
                            controller: usernameController,
                            labertext: 'Full Name',
                            hinttext: 'Full Name',
                            keybroad: TextInputType.multiline,
                            icon: Icons.person,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: BuildTextField(
                            controller: emailController,
                            labertext: 'Email',
                            hinttext: 'ex@gmail.com',
                            keybroad: TextInputType.emailAddress,
                            icon: Icons.email,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: BuildTextField(
                            controller: passwordController,
                            labertext: 'Password',
                            hinttext: 'Password',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: BuildTextField(
                            controller: confirmpasswordController,
                            labertext: 'Comfirm Password',
                            hinttext: 'Comfirm Password',
                          ),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ButtonEmail(context),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 3,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          8.0), // Khoảng cách giữa Divider và Text
                                  child: Text(
                                    'Or',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 3,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              // Xử lý đăng nhập
                              print("Email: ${emailController.text}");
                              print("Mật khẩu: ${passwordController.text}");
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Image.asset(
                                    'assets/images/na.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                                const Text(
                                  "Continue with Google",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              // Xử lý đăng nhập
                              print("Email: ${emailController.text}");
                              print("Mật khẩu: ${passwordController.text}");
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Image.asset(
                                    'assets/images/facebook.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                                const Text(
                                  "Continue with E-mail",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField BuildTextField({
    required TextEditingController controller,
    required String labertext,
    required String hinttext,
    TextInputType keybroad = TextInputType.text,
    IconData? icon,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: labertext,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: Colors.blue), // Màu viền khi focus
        ),
      ),
      keyboardType: keybroad,
    );
  }

  ElevatedButton ButtonEmail(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Check if the passwords match
        if (passwordController.text != confirmpasswordController.text) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'Password Mismatch',
                  style: TextStyle(color: Colors.black),
                ),
                content: Text(
                  'The passwords do not match. Please try again.',
                  style: TextStyle(color: Colors.black),
                ),
              );
            },
          );
          return;
        }
        // Kiểm tra mật khẩu phải dài hơn 8 ký tự và chứa cả chữ và số
        String password = passwordController.text;
        RegExp passwordRegExp = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{8,}$');

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
        // Check if email is valid
        final email = emailController.text;
        final emailRegex =
            RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
        if (!emailRegex.hasMatch(email)) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'Invalid Email',
                  style: TextStyle(color: Colors.black),
                ),
                content: Text(
                  'Please enter a valid email address.',
                  style: TextStyle(color: Colors.black),
                ),
              );
            },
          );
          return;
        }

        ///
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
        try {
          final result = await apiLogin.Signup(usernameController.text,
              emailController.text, passwordController.text);
          Navigator.pop(context);
          if (result == '200') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text(
                      'Đăng ký thành công',
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
                                    builder: (context) => LoginPage()));
                          },
                          child: const Text(
                            'Go To Login',
                          ))
                    ],
                  );
                });

            // Navigator.pop(context);
          } else if (result == '409') {
            // Xử lý lỗi (ví dụ: hiển thị thông báo lỗi)
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Đăng ký thất bại',
                    style: TextStyle(color: Colors.black),
                  ),
                  content: Text(
                    'Email đã tồn tại.',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              },
            );
          } else if (result == '400') {
            // Xử lý lỗi (ví dụ: hiển thị thông báo lỗi)
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Đăng ký thất bại',
                    style: TextStyle(color: Colors.black),
                  ),
                  content: Text(
                    'Thiếu thông tin .',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              },
            );
          } else {
            // Xử lý lỗi (ví dụ: hiển thị thông báo lỗi)
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Đăng ký thất bại',
                    style: TextStyle(color: Colors.black),
                  ),
                  content: Text(
                    'Lỗi máy chủ.',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              },
            );
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
          minimumSize: const Size(200, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      child: const Text(
        "Register",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
