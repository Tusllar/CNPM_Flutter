import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../controller/APIservice/ApiService.dart';
import '../BottomNavBar.dart';
import 'WidgetSelect/CustomButtom.dart';
import 'WidgetSelect/NewMobiTicket.dart';
import 'WidgetSelect/TicketWidget.dart';

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
      required this.seat_id,
      required this.time_id});
  final String date;
  final String time;
  final String seats;
  final String price;
  final int row;
  final String link;
  final String title;
  final int? seat_id;
  final int time_id;
  @override
  State<TicketBook> createState() => _TicketState();
}

class _TicketState extends State<TicketBook> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  ApiService apiService = ApiService();
  int? user_id;
  bool buttom = true;
  Future<void> _loadUserData() async {
    // Lấy dữ liệu người dùng từ FlutterSecureStorage
    String? id = await storage.read(key: 'id');
    setState(() {
      user_id = id != null ? int.tryParse(id) : null;
      // Kiểm tra trạng thái đăng nhập
    });
  }

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          children: [
            const NewMobieTicket(),
            TicketWidget(
              date: widget.date,
              time: widget.time,
              seats: widget.seats,
              price: widget.price,
              row: widget.row,
              link: widget.link,
              title: widget.title,
              ticket_id: widget.seat_id ?? 0,
            ),
            if (widget.time_id == 0) ...[
              CustomButton(
                text: "Home",
                color: Colors.blue,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBar(),
                    ),
                  );
                },
              ),
            ] else ...[
              buttom
                  ? CustomButton(
                      text: "Buy",
                      color: const Color(0XFFFF53C0),
                      onPressed: () async {
                        final int? seatId = await apiService.saveseat(
                          widget.time_id,
                          widget.seats,
                        );
                        setState(() {
                          buttom = !buttom; // Đổi trạng thái khi bấm "Buy"
                        });
                        await apiService.saveticket(
                          user_id,
                          seatId,
                          int.parse(widget.price),
                        );
                      },
                    )
                  : CustomButton(
                      text: "Home",
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNavBar()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
            ]
          ],
        ),
      ),
    );
  }
}
