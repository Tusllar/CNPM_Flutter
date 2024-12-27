import 'package:flutter/material.dart';

import '../../../controller/APIservice/ApiLogin.dart';
import '../../BottomNavBar.dart';
import '../ResetPassword/ForgetPass.dart';
import '../SignUp/SignupPage.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiLogin apiLogin = ApiLogin();
  bool _obs = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/images/lo.png',
              height: 100,
              width: 300,
            ),
          ),
          Stack(
            children: [
              Container(
                height: 600,
                width: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavBar()));
                            },
                            icon: const Icon(
                              Icons.home,
                              size: 30,
                            )),
                        const SizedBox(width: 60),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )),
                    ],
                  ),
                  const SizedBox(height: 30), // Adjusted spacing
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: BuildTextField(
                      Controller: emailController,
                      laber: 'Email',
                      hint: 'ex@gmail.com',
                      type: TextInputType.emailAddress,
                      icon: Icons.email,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.black),
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obs = !_obs;
                            });
                          },
                          child: Icon(
                            _obs ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText: _obs,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Forgetpass()));
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      );
                      try {
                        final String result = await apiLogin.Signin(
                            emailController.text, passwordController.text);
                        Navigator.pop(context);
                        if (result == '200') {
                          // await saveUserData(id, email, name, pass);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text(
                                    'Đăng Nhập Thành Công',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const BottomNavBar()),
                                            ModalRoute.withName('/'),
                                          );
                                        },
                                        child: const Text(
                                          'Go To Login',
                                        ))
                                  ],
                                );
                              });
                        } else if (result == '401') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text(
                                  'Mật khẩu không chính xác',
                                  style: TextStyle(color: Colors.black),
                                ),
                                content: Text(
                                  'Vui lòng nhập lại mật khẩu.',
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text(
                                  'Tài Khoản không tồn tại',
                                  style: TextStyle(color: Colors.black),
                                ),
                                content: Text(
                                  'Vui lòng nhập đăng kí.',
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

                      // apiLogin.getUserData();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF0077FF),
                        minimumSize: const Size(250, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    padding: const EdgeInsets.symmetric(horizontal: 30),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    padding: const EdgeInsets.symmetric(horizontal: 30),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
            ],
          ),
        ],
      ),
    );
  }
}

class BuildTextField extends StatelessWidget {
  const BuildTextField(
      {super.key,
      required this.Controller,
      required this.laber,
      required this.hint,
      this.icon,
      required this.type});

  final TextEditingController Controller;
  final String laber;
  final String hint;
  final IconData? icon;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: Controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: laber,
        labelStyle: const TextStyle(color: Colors.black),
        hintText: hint,
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
      keyboardType: type,
    );
  }
}
