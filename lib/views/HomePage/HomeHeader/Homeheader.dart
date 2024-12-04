import 'package:flutter/material.dart';

class Homeheader extends StatefulWidget {
  const Homeheader({
    super.key,
  });

  @override
  State<Homeheader> createState() => _HomeheaderState();
}

class _HomeheaderState extends State<Homeheader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 380,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Colors.blue),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
              Padding(
                padding: EdgeInsets.only(left: 95),
                child: Icon(
                  Icons.notifications,
                  size: 35,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
