import 'package:Movie/views/BottomNavBar.dart';
import 'package:flutter/material.dart';
// import 'views/BottomNavBar/BottomNavBar.dart';

void main() {
  runApp(const MyApp());
}

class DarkTheme {
  static const Color darkerBackground = Color(0xFF151414); // Màu nền xanh đậm
  static const Color white = Colors.white; // Màu trắng cho văn bản
  static const Color buttonColor = Colors.blueAccent;
  static const Color colorSearch = Colors.blueGrey; // Màu cho nút nhấn
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:
            const Color(0xFF191B2C), // Màu nền tối xanh đậm
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white, // Văn bản màu trắng
              displayColor: DarkTheme.white, // Màu văn bản lớn màu trắng
            ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BottomNavBar(),
      // home: const HomePage(),
    );
    // home: ComparisonPage(),
  }
}
