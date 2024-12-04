import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        color: Colors.white,
        child: Text('data'),
      ),
    );
  }
}
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Đăng Nhập",
//           style: TextStyle(fontSize: 25),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SignupPage()),
//               );
//             },
//             child: const Text(
//               "Đăng Ký",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//       body: LoginForm(),
//     );
//   }
// }
//
// class LoginForm extends StatefulWidget {
//   @override
//   State<LoginForm> createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<LoginForm> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _obs = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               SizedBox(
//                 width: 300,
//                 height: 300,
//                 child: Image.asset(
//                   "assets/images/h1.png",
//                   scale: 0.8,
//                 ),
//               ),
//               const SizedBox(height: 40), // Adjusted spacing
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: "Email",
//                   prefixIcon: const Icon(Icons.person),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: passwordController,
//                 decoration: InputDecoration(
//                   labelText: "Mật khẩu",
//                   suffixIcon: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _obs = !_obs;
//                       });
//                     },
//                     child: Icon(
//                       _obs ? Icons.visibility : Icons.visibility_off,
//                     ),
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 obscureText: _obs,
//               ),
//               const SizedBox(height: 32),
//               ElevatedButton(
//                 onPressed: () {
//                   // Xử lý đăng nhập
//                   print("Email: ${emailController.text}");
//                   print("Mật khẩu: ${passwordController.text}");
//                 },
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 50),
//                 ),
//                 child: const Text("Đăng Nhập"),
//               ),
//               const SizedBox(height: 16),
//               TextButton(
//                 onPressed: () {
//                   // Handle forgot password action
//                   print("Forgot password?");
//                 },
//                 child: const Text(
//                   "Quên mật khẩu?",
//                   style: TextStyle(fontSize: 14),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
