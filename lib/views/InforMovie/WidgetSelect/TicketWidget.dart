import 'package:flutter/material.dart';

import '../../../controller/APIservice/ApiService.dart';
import '../../BottomNavBar.dart';

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
      required this.ticket_id});
  final String date;
  final String time;
  final String seats;
  final String price;
  final int row;
  final String link;
  final String title;
  final int ticket_id;

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Container(
      width: 250,
      height: 450,
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
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            if (ticket_id != 0) ...[
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
                                    await apiService.removeBooking(ticket_id);
                                    Navigator.of(context).pop();
                                    Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BottomNavBar()),
                                      (Route<dynamic> route) => false,
                                    );
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
            ]
          ]),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
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
