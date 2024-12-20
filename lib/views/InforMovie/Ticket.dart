import 'dart:convert';

import 'package:dangnhap/views/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TicketBook extends StatefulWidget {
  const TicketBook(
      {super.key,
      required this.date,
      required this.time,
      required this.seats,
      required this.price,
      required this.row,
      required this.link,
      required this.title,
      required this.id});
  final String date;
  final String time;
  final String seats;
  final String price;
  final int row;
  final String link;
  final String title;
  final int id;
  @override
  State<TicketBook> createState() => _TicketState();
}

class _TicketState extends State<TicketBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 20, right: 20, bottom: 40),
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
                    "Mobile Ticket",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            TicketWidget(
              date: widget.date,
              time: widget.time,
              seats: widget.seats,
              price: widget.price,
              row: widget.row,
              link: widget.link,
              title: widget.title,
              id: widget.id,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavBar()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFFFF53C0),
                    ),
                    child: const Text(
                      "Home",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TicketWidget extends StatelessWidget {
  const TicketWidget(
      {super.key,
      required this.date,
      required this.time,
      required this.seats,
      required this.price,
      required this.row,
      required this.link,
      required this.title,
      required this.id});
  final String date;
  final String time;
  final String seats;
  final String price;
  final int row;
  final String link;
  final String title;
  final int id;
  Future<void> removeBooking() async {
    const url = 'http://192.168.1.4:80/remove'; // Thay đổi địa chỉ IP phù hợp

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': id,
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
    return Container(
      width: 250,
      height: 430,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ticket Image Section
          Stack(children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                link, // Replace with your image URL
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text(
                              'Remove Ticket',
                              style: TextStyle(color: Colors.black),
                            ),
                            content: const Text(
                              'You readly remove this Ticket',
                              style: TextStyle(color: Colors.black),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Không",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  // Navigator.of(context).pop();
                                  await removeBooking();
                                  Navigator.of(context).pop();
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BottomNavBar()));
                                },
                                child: const Text(
                                  "Có",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: 30,
                  )),
            )
          ]),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0XFF8E11D1)),
          ),
          // Ticket Details Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildDetailText("Date:", date),
                        const SizedBox(height: 5),
                        buildDetailText("Time:", time),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildDetailText("Row:", "$row"),
                        const SizedBox(height: 5),
                        buildDetailText("Seats:", seats),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child:
                      Center(child: buildDetailText("Total Price: \$", price)),
                ),
              ],
            ),
          ),
          SizedBox(
            // margin: const EdgeInsets.all,
            height: 60,
            child: Image.asset(
              'assets/images/Code barre.png', // Replace with barcode image
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  // Function to build ticket detail text
  Widget buildDetailText(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              color: Color(0XFF8E11D1),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(fontSize: 13, color: Colors.black),
        ),
      ],
    );
  }
}
