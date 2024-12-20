import 'dart:convert';

import 'package:dangnhap/models/data.dart';
import 'package:dangnhap/views/InforMovie/Ticket.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chooseseat extends StatefulWidget {
  const Chooseseat(
      {super.key,
      required this.date,
      required this.time,
      required this.movie2});
  final String date;
  final String time;
  final Movie2 movie2;
  @override
  State<Chooseseat> createState() => _ChooseseatState();
}

class _ChooseseatState extends State<Chooseseat> {
  final List<String> rows = ['A', 'B', 'C', 'D', 'E', 'F', 'H'];
  final List<int> rowSeatCounts = [
    4,
    6,
    8,
    8,
    6,
    8,
    8
  ]; // Số lượng ghế trên từng hàng
  Set<String> bookedSeats = {'A1', 'B2', 'C3'};
  Set<String> Seats = {};
  int price = 30;
  Future<void> saveBooking() async {
    const url = 'http://192.168.1.4:80/save'; // Thay đổi địa chỉ IP phù hợp

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'date': widget.date,
          'time': widget.time,
          'seats': Seats.isEmpty ? 'No seat' : Seats.join(', '),
          'totalPrice': Seats.length * price,
          'backdropPath': widget.movie2.backdropPath,
          'title': widget.movie2.title,
          'row_seat': Seats.isEmpty ? 0 : Seats.length
        }),
      );

      if (response.statusCode == 200) {
        print('Booking saved successfully!');
      } else {
        print('Failed to save booking. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                const Text(
                  "Choose Seats",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Image.asset("assets/images/Screen.png"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: rows.length,
                itemBuilder: (context, rowIndex) {
                  String rowLabel = rows[rowIndex];
                  int seatCount = rowSeatCounts[rowIndex];

                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10, // Khoảng cách giữa các ghế ngang
                    // runSpacing: 100, // Khoảng cách giữa các hàng
                    children: List.generate(seatCount, (seatIndex) {
                      String seatLabel = '$rowLabel${seatIndex + 1}';
                      Color seatColor;
                      if (bookedSeats.contains(seatLabel)) {
                        seatColor = const Color(0xffB6116B); // Màu ghế đã đặt
                      } else if (Seats.contains(seatLabel)) {
                        seatColor = Colors.green; // Màu ghế đã chọn
                      } else {
                        seatColor = Colors.white; // Màu ghế trống
                      }

                      return GestureDetector(
                        onTap: () {
                          if (bookedSeats.contains(seatLabel)) {
                            return;
                          }
                          setState(() {
                            if (Seats.contains(seatLabel)) {
                              Seats.remove(seatLabel);
                            } else {
                              Seats.add(seatLabel);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: 30, // Chiều cao ghế nhỏ hơn
                            width: 30, // Chiều rộng ghế nhỏ hơn
                            decoration: BoxDecoration(
                              color: seatColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Center(
                              child: Text(
                                seatLabel,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12, // Font chữ nhỏ hơn
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white24,
                ),
                width: 300,
                height: 150,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              '  ${widget.date}',
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              Icons.access_time_filled,
                              color: Colors.white,
                            ),
                            Text(
                              '  ${widget.time}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Row(
                          children: [
                            Icon(
                              Icons.confirmation_num,
                              color: Colors.white,
                            ),
                            Text(
                              '  VIP Section   ',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.event_seat,
                              color: Colors.white,
                            ),
                            Text(
                              '  Seats: ${Seats.isEmpty ? 'No seat' : Seats.join(', ')}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            Text(
                              '  Total: \$ ${Seats.length * price}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  await saveBooking();
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TicketBook(
                  //       date: widget.date,
                  //       time: widget.time,
                  //       seats: Seats.isEmpty ? 'No seat' : Seats.join(', '),
                  //       price: '${Seats.length * price}',
                  //       row: Seats.length,
                  //       link: widget.movie2.backdropPath ?? 'No',
                  //       title: widget.movie2.title ?? "No",
                  //       id: 0,
                  //     ),
                  //   ),
                  //   // Đây là cách sử dụng đúng
                  // );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicketBook(
                                date: widget.date,
                                time: widget.time,
                                seats: Seats.isEmpty
                                    ? 'No seat'
                                    : Seats.join(', '),
                                price: '${Seats.length * price}',
                                row: Seats.length,
                                link: widget.movie2.backdropPath ?? 'No',
                                title: widget.movie2.title ?? "No",
                                id: 0,
                              )));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFFFF53C0)),
                child: const Text(
                  'Buy',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
