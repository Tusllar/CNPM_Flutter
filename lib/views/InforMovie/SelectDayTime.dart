import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../models/data.dart';
import 'WidgetSelect/ButtonDateTime.dart';
import 'WidgetSelect/StackImage.dart';

class Selectdaytime extends StatefulWidget {
  const Selectdaytime({super.key, required this.movie2});
  final Movie2 movie2;
  @override
  State<Selectdaytime> createState() => _SelectdaytimeState();
}

class _SelectdaytimeState extends State<Selectdaytime> {
  bool isExpanded = false;
  int? selectedDayIndex; // Chỉ số ngày được chọn
  int? selectedTimeIndex; // Chỉ số giờ được chọn

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String text = widget.movie2.overview ?? "No";
    const int maxChars = 150;
    final String displayText = isExpanded
        ? text
        : (text.length > maxChars ? text.substring(0, maxChars) + '...' : text);

    final List<String> days = [
      'Thu 21',
      'Fri 22',
      'Sat 23',
      'Sun 24',
      'Mon 25'
    ];
    final List<String> times = ['16:00', '17:00', '18:00', '19:00', '20:00'];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hình ảnh và thông tin nội dung
              StackImage(
                size: size,
                movie2: widget.movie2,
              ),
              const SizedBox(height: 30),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    text: TextSpan(
                      text: displayText,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 15),
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
              ),
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
              // Danh sách ngày dùng CarouselSlider
              CarouselSlider.builder(
                itemCount: days.length,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
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
                            days[index],
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
                    ),
                  );
                },
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  aspectRatio: 4,
                  viewportFraction: 0.2,
                ),
              ),
              const SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount: times.length,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedTimeIndex == index
                            ? const Color(0xffDD1C85)
                            : const Color(0xff2E1371),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          times[index],
                          style: TextStyle(
                              color: selectedTimeIndex == index
                                  ? Colors.white
                                  : Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  aspectRatio: 5,
                  viewportFraction: 0.2,
                ),
              ),
              // const Spacer(),
              // Nút Lưu
              const SizedBox(height: 50),
              // const ButtonDateTime(),
              (selectedDayIndex != null && selectedTimeIndex != null)
                  ? ButtonDateTime(
                      date: days[selectedDayIndex!],
                      time: times[selectedTimeIndex!],
                      movie2: widget.movie2,
                    )
                  : const SizedBox(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
