import 'package:dangnhap/views/InforMovie/ChooseSeat.dart';
import 'package:flutter/material.dart';

import '../../../controller/APIservice/ApiService.dart';
import '../../../models/class_movie.dart';
import '../../../models/class_schedule.dart';

class ButtonDateTime extends StatefulWidget {
  const ButtonDateTime({
    super.key,
    required this.date,
    required this.time,
    required this.movie2,
    required this.time_id,
  });
  final String date;
  final String time;
  final Movie2 movie2;
  final int time_id;
  @override
  State<ButtonDateTime> createState() => _ButtonDateTimeState();
}

class _ButtonDateTimeState extends State<ButtonDateTime> {
  Set<String> bookedSeats = {};
  ApiService apiService = ApiService();
  late Future<Seat> seat;
  @override
  void initState() {
    super.initState();
    seat = apiService.fetchSeats(widget.time_id);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: FutureBuilder<Seat>(
            future: seat,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('ERROR: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                Set<String> book = snapshot.data!.seats;
                bookedSeats = book;
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chooseseat(
                          date: widget.date,
                          time: widget.time,
                          movie2: widget.movie2,
                          time_id: widget.time_id,
                          bookedSeats1: bookedSeats,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            }),
        // child: ElevatedButton(
        //   onPressed: () {
        //     print(widget.time_id);
        //     print(bookedSeats);
        //     print(seat);
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => Chooseseat(
        //           date: widget.date,
        //           time: widget.time,
        //           movie2: widget.movie2,
        //           time_id: widget.time_id,
        //         ),
        //       ),
        //     );
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.pink,
        //     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //   ),
        //   child: const Text(
        //     'Save',
        //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //   ),
        // ),
      ),
    );
  }
}
