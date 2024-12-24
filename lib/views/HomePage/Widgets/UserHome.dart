import 'package:dangnhap/views/LoginPage/SignIn/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../controller/APIservice/Storage.dart';

class UserHome extends StatefulWidget {
  const UserHome({
    super.key,
  });

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Storage s = Storage();
  String? userName;
  String? userEmail;
  int? user_id;
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    s.loadUserData(_onUserDataLoaded);
  }

  void _onUserDataLoaded(String? name, String? email, int? id, bool loggedIn) {
    setState(() {
      userName = name ?? "Guest";
      userEmail = email ?? "guest@example.com";
      user_id = id;
      isLoggedIn = loggedIn;
    });
  }
  // Future<void> _loadUserData(String? userName, int? user_id, String? userEmail,
  //     bool isLoggedIn) async {
  //   // Lấy dữ liệu người dùng từ FlutterSecureStorage
  //   String? id = await storage.read(key: 'id');
  //   String? name = await storage.read(key: 'name');
  //   String? email = await storage.read(key: 'email');
  //   setState(() {
  //     userName = name ?? "Guest";
  //     userEmail = email ?? "guest@example.com";
  //     user_id = id != null ? int.tryParse(id) : null;
  //     isLoggedIn = user_id != null &&
  //         userName != "Guest" &&
  //         userEmail != "guest@example.com";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Stack(children: [
        Container(
          width: 378,
          height: 104,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.indigoAccent,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: isLoggedIn
                    ? null // Không điều hướng nếu đã đăng nhập
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                child: ClipOval(
                  child: Container(
                    color: Colors.deepPurpleAccent,
                    child: Image.asset(
                      "assets/images/hi.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello,$userName"),
                    Text(
                      userEmail ?? 'No',
                      style: const TextStyle(fontSize: 13),
                    ),
                    // Text('$user_id'),
                  ],
                ),
              ),
              // const SizedBox(
              //   width: 20,
              // ),
              // IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
            ],
          ),
        ),
      ]),
    );
  }
}
