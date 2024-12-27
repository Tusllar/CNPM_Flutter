import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/class_movie.dart';
import '../SetPerson/Widget/ButtomPop.dart';
import 'SelectDayTime.dart';
import 'WidgetSelect/TitleMovie.dart';

class Showinfor extends StatefulWidget {
  const Showinfor({super.key, required this.movie2});
  final Movie2 movie2;
  @override
  State<Showinfor> createState() => _ShowinforState();
}

class _ShowinforState extends State<Showinfor> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  bool isExpanded = false;
  late int? user_id;
  bool isLoggedIn = false;
  late YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.movie2.video_id ?? 'Bd1VbgHOKbA',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    _loadUserData();
    super.initState();
  }

  Future<void> _loadUserData() async {
    String? id = await storage.read(key: 'id');
    String? name = await storage.read(key: 'name');
    String? email = await storage.read(key: 'email');
    setState(() {
      user_id = id != null ? int.tryParse(id) : null;
      isLoggedIn = user_id != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    String text = widget.movie2.overview ?? "No";
    const int maxChars = 200;
    final String displayText = isExpanded
        ? text
        : (text.length > maxChars ? '${text.substring(0, maxChars)}...' : text);
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
                      widget.movie2.backdropPath != null &&
                              widget.movie2.backdropPath!.isNotEmpty
                          ? '${widget.movie2.backdropPath}'
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
                  buildinformovie(size, displayText, text, maxChars, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildinformovie(Size size, String displayText, String text,
      int maxChars, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Buttompop(),
            SizedBox(height: size.height / 4),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.cyan,
            ),
            Row(
              children: [
                TitleMovie(
                  size: size,
                  movie2: widget.movie2,
                ),
              ],
            ),
            const SizedBox(height: 20),
            BuildText(
              laber: 'Genre',
              widget: '${widget.movie2.genre}',
            ),
            BuildText(
              laber: 'Language',
              widget: '${widget.movie2.language}',
            ),
            BuildText(
              laber: 'Actors',
              widget: '${widget.movie2.actors}',
            ),
            BuildText(
              laber: 'Time',
              widget: '${widget.movie2.time_movie}',
            ),
            BuildText(
              laber: 'Director',
              widget: '${widget.movie2.director}',
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
            buildRichText(displayText, text, maxChars),
            const SizedBox(height: 40),
            if (isLoggedIn) ...[
              buildButtom(context),
            ]
            // buildButtom(context),
          ],
        ),
      ),
    );
  }

  Center buildButtom(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: ElevatedButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Selectdaytime(movie2: widget.movie2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Save',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  RichText buildRichText(String displayText, String text, int maxChars) {
    return RichText(
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
    );
  }

  Text BuildText({required String laber, required String widget}) {
    return Text(
      "$laber: $widget",
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 15,
      ),
    );
  }
}
