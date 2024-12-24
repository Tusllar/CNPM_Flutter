import 'package:dangnhap/views/HomePage/HomePage.dart';
import 'package:flutter/material.dart';

import 'SearchPage/HomeSearch.dart';
import 'SetPerson/Setting.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

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
