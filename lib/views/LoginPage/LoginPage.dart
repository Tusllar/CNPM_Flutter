import 'package:dangnhap/views/BottomNavBar.dart';
import 'package:dangnhap/views/LoginPage/ForgetPass.dart';
import 'package:dangnhap/views/LoginPage/SignupPage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFFE4EBE5),
        appBar: AppBar(
          backgroundColor: const Color(0XFFE4EBE5),
          title: const Text(
            "Back",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          leading: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavBar()));
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                size: 30,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              LoginForm(),
            ],
          ),
        ));
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
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xffA7CEAB),
              labelText: "Email",
              labelStyle: const TextStyle(color: Colors.black),
              hintText: "ex@email.com",
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: const Icon(
                Icons.email,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Colors.blue), // Màu viền khi focus
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xffA7CEAB),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Forgetpass()));
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Xử lý đăng nhập
              print("Email: ${emailController.text}");
              print("Mật khẩu: ${passwordController.text}");
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
          SizedBox(height: 15),
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
          SizedBox(height: 20),
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
