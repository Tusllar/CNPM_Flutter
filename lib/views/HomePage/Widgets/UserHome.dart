import 'package:dangnhap/views/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  const UserHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: 378,
        height: 104,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFF00B7FF),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: ClipOval(
                child: Image.asset(
                  "assets/images/user.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Heloo,Tú"),
                  Text("tutran56324@gmail.com"),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
      ),
    );
  }
}
