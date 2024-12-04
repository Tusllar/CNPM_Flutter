import 'package:dangnhap/controller/APIservice/ApiService.dart';
import 'package:dangnhap/models/data.dart';
import 'package:dangnhap/views/HomePage/HomeHeader/Homeheader.dart';
import 'package:dangnhap/views/HomePage/Nowplaying/Nowplaying.dart';
import 'package:dangnhap/views/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';

const Color darkerBackground = Color(0xFF0A0E21);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> data;
  ApiService apiService = ApiService();
  @override
  void initState() {
    super.initState();
    data = apiService.Getdata();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkerBackground,
          title: const Text(
            "Movie",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 40, color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'johndoe@example.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  print("home");
                },
              ),
              const ListTile(
                title: Text('Setting'),
                leading: Icon(Icons.settings),
              ),
              const ListTile(
                title: Text("About"),
                leading: Icon(Icons.info),
              ),
              const Divider(
                height: 0.2,
              ),
              const ListTile(
                title: Text("Sign out"),
                leading: Icon(Icons.logout),
              ),
              ListTile(
                title: const Text('Login'),
                leading: const Icon(Icons.login),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Homeheader(),
              Nowplaying(
                data1: data,
                headlineText: "Now Playing",
                size: size,
              ),
              Nowplaying(
                data1: data,
                headlineText: "Cooming Soon",
                size: size,
              ),
            ],
          ),
        ));
  }
}
