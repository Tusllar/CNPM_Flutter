import 'package:carousel_slider/carousel_slider.dart';
import 'package:dangnhap/controller/APIservice/ApiService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../models/class_movie.dart';
import '../../models/class_schedule.dart';
import 'WidgetSelect/ButtonDateTime.dart';
import 'WidgetSelect/StackImage.dart';

class Selectdaytime extends StatefulWidget {
  const Selectdaytime({super.key, required this.movie2});
  final Movie2 movie2;
  @override
  State<Selectdaytime> createState() => _SelectdaytimeState();
}

class _SelectdaytimeState extends State<Selectdaytime> {
  Set<String> bookedSeats = {};
  ApiService apiService = ApiService();
  late Future<Seat> seat;
  bool isExpanded = false;
  bool showDateTimePicker = false; // Biến trạng thái để hiển thị danh sách
  int? selectedDayIndex; // Chỉ số ngày được chọn
  int? selectedTimeIndex; // Chỉ số giờ được chọn
  String? d;
  String? t;
  late int selectTimeid;
  late Future<List<Date>> date;
  late Future<List<Time>> time;
  @override
  void initState() {
    super.initState();
    date = apiService.getDate(widget.movie2.id);
    time = Future.value([]);
    // seat = apiService.fetchSeats(selectTimeid);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String text = widget.movie2.overview ?? "No";
    const int maxChars = 150;
    final String displayText = isExpanded
        ? text
        : (text.length > maxChars ? text.substring(0, maxChars) + '...' : text);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StackImage(
                size: size,
                movie2: widget.movie2,
              ),
              buildReview(displayText, text, maxChars),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Select Date & Time',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              buildFutureBuilderDate(),
              if (showDateTimePicker) ...[
                buildFutureBuilderTime(),
              ],
              const SizedBox(height: 50),
              (selectedDayIndex != null && selectedTimeIndex != null)
                  ? ButtonDateTime(
                      date: d ?? "No",
                      time: t ?? "No",
                      movie2: widget.movie2,
                      time_id: selectTimeid,
                    )
                  : const SizedBox(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<Time>> buildFutureBuilderTime() {
    return FutureBuilder<List<Time>>(
      future: time,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final times = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                CarouselSlider(
                  items: times.map((time) {
                    int index = times.indexOf(time);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          t = time.time;
                          selectTimeid = time.id;
                          if (selectedTimeIndex == index) {
                            selectedTimeIndex = null;
                          } else {
                            selectedTimeIndex = index;
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: selectedTimeIndex == index
                              ? const Color(0xffDD1C85)
                              : const Color(0xff2E1371),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${time.time}',
                            style: TextStyle(
                              color: selectedTimeIndex == index
                                  ? Colors.white
                                  : Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        selectedTimeIndex = null;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  FutureBuilder<List<Date>> buildFutureBuilderDate() {
    return FutureBuilder<List<Date>>(
      future: date,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final dates = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                CarouselSlider(
                  items: dates.map((day) {
                    int index = dates.indexOf(day);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          showDateTimePicker = true;
                          time = apiService.getTime(day.id);
                          d = day.date;
                          if (selectedDayIndex == index) {
                            selectedDayIndex = null;
                          } else {
                            selectedDayIndex = index;
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: selectedDayIndex == index
                              ? const Color(0xffDD1C85)
                              : const Color(0xff2E1371),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            day.date ?? 'No Date',
                            style: TextStyle(
                              color: selectedDayIndex == index
                                  ? Colors.white
                                  : Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        selectedDayIndex = null;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }

  Center buildReview(String displayText, String text, int maxChars) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RichText(
          text: TextSpan(
            text: displayText,
            style: const TextStyle(color: Colors.white70, fontSize: 15),
            children: [
              if (text.length > maxChars)
                TextSpan(
                  text: isExpanded ? ' Read Less' : ' Read More',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
