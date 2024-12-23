import 'package:dangnhap/controller/APIservice/ApiLogin.dart';
import 'package:dangnhap/views/BottomNavBar.dart';
import 'package:flutter/material.dart';

import '../../ResetPassword/ForgetPass.dart';
import '../../SignUp/SignupPage.dart';

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
          const Text(
            'Welcome \nBack',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Fill in the form anf create and account.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black26,
              ),
            ),
          ),

          const SizedBox(height: 30), // Adjusted spacing
          BuildTextField(
            Controller: emailController,
            laber: 'Email',
            hint: 'ex@gmail.com',
            type: TextInputType.emailAddress,
            icon: Icons.email,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffA7CEAB),
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
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const Center(child: CircularProgressIndicator());
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
              minimumSize: const Size(300, 50),
            ),
            child: const Text(
              "Sign In with E-mail",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                'Or',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Xử lý đăng nhập
              print("Email: ${emailController.text}");
              print("Mật khẩu: ${passwordController.text}");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFFE91639),
              minimumSize: const Size(double.infinity, 60),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    'assets/images/goolge.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                const Text(
                  "Sign In with Google",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              // Xử lý đăng nhập
              print("Email: ${emailController.text}");
              print("Mật khẩu: ${passwordController.text}");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFF0077FF),
              minimumSize: const Size(double.infinity, 60),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    'assets/images/facebook.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                const Text(
                  "Sign In with E-mail",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Have an Account ?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  )),
            ],
          )
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
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffA7CEAB),
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
