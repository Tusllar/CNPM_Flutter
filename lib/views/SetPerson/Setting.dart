import 'package:dangnhap/controller/APIservice/ApiService.dart';
import 'package:dangnhap/controller/APIservice/Storage.dart';
import 'package:dangnhap/models/data.dart';
import 'package:dangnhap/views/BottomNavBar.dart';
import 'package:dangnhap/views/HomePage/Widgets/UserHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../LoginPage/SignIn/LoginPage.dart';
import 'Widget/ButtomLoginout.dart';
import 'Widget/EditInfor.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EditInfor(),
            const SizedBox(height: 15),
            const UserHome(),
            const SizedBox(height: 30),
            buildCenterTicket(),
            buildTicket(context)
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
