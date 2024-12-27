import 'package:flutter/material.dart';

import '../controller/APIservice/ApiService.dart';
import '../models/class_video_id.dart';
import 'HomePage/HomePage.dart';
import 'SearchPage/HomeSearch.dart';
import 'SetPerson/Setting.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  ApiService fetmovie = ApiService();
  late Future<Video> id;
  late List<String> video;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "Setting",
              ),
            ],
            unselectedLabelColor: Color(0xFF999999),
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
          ),
        ),
        body: const TabBarView(
          children: [
            Homepage(),
            Homesearch(),
            // Profile(),
            Setting(),
            // SearchScreen(),
            // MoreScreen(),
          ],
        ),
      ),
    );
  }
}
