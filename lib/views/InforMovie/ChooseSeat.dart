import 'package:dangnhap/controller/APIservice/ApiService.dart';
import 'package:dangnhap/views/InforMovie/Ticket.dart';
import 'package:flutter/material.dart';

import '../../models/class_movie.dart';

class Chooseseat extends StatefulWidget {
  final String date;
  final String time;
  final Movie2 movie2;
  final int time_id;
  final Set<String> bookedSeats1;

  const Chooseseat({
    Key? key,
    required this.date,
    required this.time,
    required this.movie2,
    required this.time_id,
    required this.bookedSeats1,
  }) : super(key: key);

  @override
  _ChooseseatState createState() => _ChooseseatState();
}

class _ChooseseatState extends State<Chooseseat> {
  final List<String> rows = ['A', 'B', 'C', 'D', 'E', 'F', 'H'];
  final List<int> rowSeatCounts = [4, 6, 8, 8, 6, 8, 8];
  late Set<String> bookedSeats = widget.bookedSeats1;
  Set<String> selectedSeats = {};
  int price = 30;
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(),
          Image.asset("assets/images/Screen.png"),
          Expanded(child: _buildSeatsGrid()),
          _buildSeatsLegend(),
          _buildBookingSummary(),
          _buildBuyButton(),
        ],
      ),
    );
  }

  Padding _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_month, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatsGrid() {
    return ListView.builder(
      itemCount: rows.length,
      itemBuilder: (context, rowIndex) {
        String rowLabel = rows[rowIndex];
        int seatCount = rowSeatCounts[rowIndex];

        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          children: List.generate(seatCount, (seatIndex) {
            String seatLabel = '$rowLabel${seatIndex + 1}';
            Color seatColor = _getSeatColor(seatLabel);

            return GestureDetector(
              onTap: () {
                if (!bookedSeats.contains(seatLabel)) {
                  setState(() {
                    selectedSeats.contains(seatLabel)
                        ? selectedSeats.remove(seatLabel)
                        : selectedSeats.add(seatLabel);
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 30,
                  width: 30,
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
                        fontSize: 12,
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
    );
  }

  Color _getSeatColor(String seatLabel) {
    print('Booked Seats: $bookedSeats');
    // print('Checking seat: $seatLabel');
    if (bookedSeats.contains(seatLabel)) {
      print('Checking seat: $seatLabel');
      return const Color(0xffB6116B); // Reserved color
    } else if (selectedSeats.contains(seatLabel)) {
      return Colors.green; // Selected color
    } else {
      return Colors.white; // Available color
    }
  }

  Padding _buildSeatsLegend() {
    return const Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Static(content: 'Available', color: Colors.white),
          Static(content: 'Reserved', color: Color(0xffB6116B)),
          Static(content: 'Selected', color: Colors.green),
        ],
      ),
    );
  }

  Padding _buildBookingSummary() {
    return Padding(
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
                      const Icon(Icons.calendar_month_outlined,
                          color: Colors.white),
                      Text('  ${widget.date}',
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(width: 15),
                      const Icon(Icons.access_time_filled, color: Colors.white),
                      Text('  ${widget.time}',
                          style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Icon(Icons.confirmation_num, color: Colors.white),
                      Text('  VIP Section', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.event_seat, color: Colors.white),
                      Text(
                        '  Seats: ${selectedSeats.isEmpty ? 'No seat' : selectedSeats.join(', ')}',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.shopping_cart, color: Colors.white),
                      Text(
                        '  Total: \$ ${selectedSeats.length * price}',
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
    );
  }

  Padding _buildBuyButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: () async {
            // final int? seat_id = await apiService.saveseat(
            //   widget.time_id,
            //   selectedSeats.isEmpty ? 'No seat' : selectedSeats.join(', '),
            // );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TicketBook(
                  date: widget.date,
                  time: widget.time,
                  seats: selectedSeats.isEmpty
                      ? 'No seat'
                      : selectedSeats.join(', '),
                  price: '${selectedSeats.length * price}',
                  row: selectedSeats.length,
                  link: widget.movie2.backdropPath ?? 'No',
                  title: widget.movie2.title ?? 'No',
                  seat_id: null,
                  time_id: widget.time_id,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFFFF53C0)),
          child: const Text(
            'Save Seats',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class Static extends StatelessWidget {
  final String content;
  final Color color;
  const Static({Key? key, required this.content, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(5)),
        ),
        const SizedBox(width: 10),
        Text(content,
            style: const TextStyle(fontSize: 15, color: Colors.white)),
      ],
    );
  }
}
