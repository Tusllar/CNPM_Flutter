import 'package:dangnhap/controller/APIservice/ApiService.dart';
import 'package:dangnhap/controller/APIservice/Storage.dart';
import 'package:dangnhap/models/class_ticket.dart';
import 'package:dangnhap/views/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../LoginPage/SignIn/LoginPage.dart';
import 'Widget/ButtomLoginout.dart';
import 'Widget/ShowTicket.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _HomepageState();
}

class _HomepageState extends State<Setting> {
  late Future<List<Ticket>> ticket;
  ApiService fetdata = ApiService();
  Storage s = Storage();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? userName;
  String? userEmail;
  int? user_id;
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? id = await storage.read(key: 'id');
    String? name = await storage.read(key: 'name');
    String? email = await storage.read(key: 'email');
    setState(() {
      userName = name ?? "Guest";
      userEmail = email ?? "guest@example.com";
      user_id = id != null ? int.tryParse(id) : null;
      isLoggedIn = user_id != null &&
          userName != "Guest" &&
          userEmail != "guest@example.com";
    });
    ticket = fetdata.ticketapp(user_id);
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '$userName',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF191B2C),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 180,
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                            color: Color(0xFF191B2C),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50))),
                      ),
                      Positioned(
                        top: 40,
                        left: MediaQuery.of(context).size.width * 0.5 - 60,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/hi.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: const Color(0xF2EABBD0),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Icon(
                                          Icons.email,
                                          size: 20,
                                          color: Color(0xFFE53E8F),
                                        )),
                                    const SizedBox(width: 10),
                                    Text('${userEmail}'),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 110,
                        left: MediaQuery.of(context).size.width * 0.5 + 30,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF191B2C),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF191B2C),
                  ),
                  child: const Center(
                    child: Text(
                      "Your Ticket",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      if (isLoggedIn) ...[
                        const SizedBox(height: 10),
                        Center(
                          child: SingleChildScrollView(
                              child: ShowTicket(ticket: ticket)),
                        ),
                      ],
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        'DOCUMENTATION',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black26),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.privacy_tip,
                              color: Colors.cyan,
                            ),
                            SizedBox(width: 30),
                            Text(
                              'Privacy Policy',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.share,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 30),
                            Text(
                              'Share Profile',
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      if (isLoggedIn) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.login,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 20),
                              TextButton(
                                  onPressed: () {
                                    s.logout(context);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BottomNavBar()),
                                      ModalRoute.withName('/'),
                                    );
                                  },
                                  child: const Text(
                                    'Log Out',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 15),
                                  ))
                            ],
                          ),
                        ),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.login,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 30),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  },
                                  child: const Text(
                                    'Log In',
                                    style: TextStyle(color: Colors.blue),
                                  ))
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            // const EditInfor(),
            // const SizedBox(height: 15),
            // const UserHome(),
            // const SizedBox(height: 30),
            // buildCenterTicket(),
            // buildTicket(context)
          ],
        ),
      ),
    );
  }

  Column buildTicket(BuildContext context) {
    return Column(
      children: [
        if (isLoggedIn) ...[
          const SizedBox(height: 30),
          Center(
            child: ShowTicket(ticket: ticket),
          ),
          const SizedBox(height: 20),
          // ButtomLoginout(s: s),
          ActionButton(
            buttonText: "Logout",
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            onPressed: () {
              s.logout(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const BottomNavBar()),
                ModalRoute.withName('/'),
              );
            },
          ),
          const SizedBox(height: 20),
        ] else ...[
          const SizedBox(height: 50),
          ActionButton(
            buttonText: "Login",
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
        const SizedBox(height: 20),
      ],
    );
  }

  Center buildCenterTicket() {
    return Center(
      child: Container(
        height: 45,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: const Center(
          child: Text(
            "Your Ticket",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
