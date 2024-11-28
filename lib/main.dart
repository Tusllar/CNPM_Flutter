import 'package:dangnhap/views/LoginPage.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home: ComparisonPage(),
    );
  }
}
