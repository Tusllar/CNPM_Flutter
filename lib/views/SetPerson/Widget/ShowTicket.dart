import 'package:flutter/material.dart';

import '../../../models/class_ticket.dart';
import '../../InforMovie/Ticket.dart';

class ShowTicket extends StatelessWidget {
  const ShowTicket({
    super.key,
    required this.ticket,
  });

  final Future<List<Ticket>> ticket;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List<Ticket>>(
            future: ticket,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                return Column(
                  children: snapshot.data!.map((ticketData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TicketBook(
                                        date: ticketData.date,
                                        time: ticketData.time,
                                        seats: ticketData.seats,
                                        price: ' ${ticketData.totalprice}',
                                        row: ticketData.row_seat,
                                        link: ticketData.backdropPath,
                                        title: ticketData.title,
                                        seat_id: ticketData.id,
                                        time_id: 0,
                                      )));
                        },
                        child: Container(
                          height: 150,
                          width: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: Column(
                            children: [
                              Text(
                                ticketData.title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            ticketData.backdropPath,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.calendar_month_outlined,
                                                color: Colors.white),
                                            Text(
                                              "  ${ticketData.date}",
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                            const SizedBox(width: 15),
                                            const Icon(Icons.access_time_filled,
                                                color: Colors.white),
                                            Text(
                                              "  ${ticketData.time}",
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(Icons.event_seat,
                                                color: Colors.white),
                                            Text(
                                              "Seats: ${ticketData.seats}",
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(Icons.shopping_cart,
                                                color: Colors.white),
                                            Text(
                                              "Total: ${ticketData.totalprice}",
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                  child: Text('No data found'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
