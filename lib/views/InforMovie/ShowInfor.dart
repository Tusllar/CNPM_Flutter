import 'package:auto_size_text/auto_size_text.dart';
import 'package:dangnhap/views/InforMovie/SelectDayTime.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../models/data.dart';

class Showinfor extends StatefulWidget {
  const Showinfor({super.key, required this.movie2});
  final Movie2 movie2;
  @override
  State<Showinfor> createState() => _ShowinforState();
}

class _ShowinforState extends State<Showinfor> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    String text = widget.movie2.overview ?? "No";
    const int maxChars = 200;
    final String displayText = isExpanded
        ? text
        : (text.length > maxChars ? text.substring(0, maxChars) + '...' : text);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Lớp Stack chứa ảnh và nội dung
            Expanded(
              child: Stack(
                children: [
                  // Hình ảnh tràn full chiều rộng
                  ClipRRect(
                    borderRadius: BorderRadius.zero, // Không có bo góc
                    child: Image.network(
                      // "https://image.tmdb.org/t/p/w500/au3o84ub27qTZiMiEc9UYzN74V3.jpg",
                      widget.movie2.posterPath != null &&
                              widget.movie2.posterPath!.isNotEmpty
                          ? 'https://image.tmdb.org/t/p/w500${widget.movie2.posterPath}'
                          : 'https://yourdefaultimageurl.com/default.jpg',
                      fit: BoxFit.cover,
                      height: 400,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    height: 400,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black12, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Nội dung hiển thị lên trên ảnh
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Positioned(
                            top: 16,
                            left: 16,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                    context); // Quay lại màn hình trước đó
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
                          ),
                          SizedBox(height: size.height / 4),
                          Row(
                            children: [
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    widget.movie2.title ?? "No",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2, // Số dòng tối đa
                                    minFontSize: 15, // Cỡ chữ nhỏ nhất
                                  ),
                                  // SizedBox(height:),
                                  const Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 15),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 15),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 15),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 15),
                                      Icon(Icons.star_border,
                                          color: Colors.yellow, size: 15),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                  Text(
                                    'Vote: ${widget.movie2.votecount}',
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 15),
                              Text(
                                widget.movie2.releaseDate ?? "No",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Language: ${widget.movie2.language}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Thời gian: ${widget.movie2.releaseDate}',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 15),
                          ),
                          const Text(
                            'Diễn viên: ......',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 15),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Overview',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              text: displayText,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 15),
                              children: [
                                if (text.length > maxChars)
                                  TextSpan(
                                    text: isExpanded
                                        ? ' Read Less'
                                        : ' Read More',
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
                          const SizedBox(height: 40),
                          Center(
                            child: SizedBox(
                              width: 300,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Selectdaytime(movie2: widget.movie2),
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
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
