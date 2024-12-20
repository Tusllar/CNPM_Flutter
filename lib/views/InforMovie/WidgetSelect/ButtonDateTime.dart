import 'package:dangnhap/views/InforMovie/ChooseSeat.dart';
import 'package:flutter/material.dart';

import '../../../models/data.dart';

class ButtonDateTime extends StatelessWidget {
  const ButtonDateTime({
    super.key,
    required this.date,
    required this.time,
    required this.movie2,
  });
  final String date;
  final String time;
  final Movie2 movie2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Chooseseat(
                  date: date,
                  time: time,
                  movie2: movie2,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Save',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
