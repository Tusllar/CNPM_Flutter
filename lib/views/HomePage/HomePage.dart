import 'dart:math';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../controller/APIservice/ApiService.dart';
import '../../models/class_movie.dart';
import '../../widget.dart';
import 'Widgets/BuildListMovie.dart';
import 'Widgets/BuildMovie.dart';
import 'Widgets/BuildUpcoming.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Movie2>> comming;
  late Future<List<Movie2>> now;
  ApiService fetmovie = ApiService();
  late FlickManager flickManager;
  late YoutubePlayerController _controller;
  List<String> video = [
    "c75XRkb2MpQ",
    "XU4oplOtoQo",
    "7oVbS8zQxQ0",
    "6ApiubHgJP4",
    "cBG30KsGRH8",
    "9rSz2Ve2XH8",
    "4oxoPMxBO6s",
    "nPKCkzde8dc",
    "XUqg9s1CvoQ",
    "ST08liEjNsw",
    "ntjmHIZHwAg",
    "ntjmHIZHwAg",
    "k_uHgoVKppU",
    "Win9L_j9Ubs",
    "0zMKy_2n7C0",
    "H6tRL4c4P8",
    "4ALt4VT7grw",
    "-Sux3ihKodI",
    "bMcNeq229Ms",
    "R4AFSgUGEEs",
    "EIARKqcXILM",
    "2T_mKyH17mY",
    "qaeHlk0OXec",
    "id1rfr_KZWg",
    "lbLk9PzHWfg",
    "kMjlJkmt5nk",
    "vHONH3M9RYU",
    "JVXPmlgEisk",
    "6z1BoUbB-fs",
    "bTJ-fHJopAI",
    "Bd1VbgHOKbA",
    "z3-woPDtfKk",
    "Cltvdvik5_U",
    "kVSKo-SF-kY"
  ];

  late String randomVideoId;
  @override
  void initState() {
    super.initState();
    now = fetmovie.Nowplay();
    comming = fetmovie.Comming();
    randomVideoId = video[Random().nextInt(video.length)];
    _controller = YoutubePlayerController(
      initialVideoId: randomVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
            Uri.parse('https://youtu.be/c75XRkb2MpQ')));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // int _currentIndex = 0;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.lightGreenAccent,
      //   title: Center(
      //     child: Image.asset(
      //       'assets/images/lo.png',
      //       height: 80,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            // const UserHome(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: BuildText(
                text: 'For You',
                color1: Colors.yellowAccent,
                color2: Colors.lightGreenAccent,
              ),
            ),
            // const BuildPadding(text: 'For You'),
            Buildmovie(popular: comming, size: size),
            const BuildText(
              text: 'Stream YouTuBe',
              color1: Colors.orange,
              color2: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.cyan,
              ),
            ),
            const SizedBox(height: 20),
            buildTextPadding(text: ' Now Playing', s: size),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Divider(
                thickness: 3,
                color: Colors.grey,
              ),
            ),
            BuildUpcoming(size: size, movie: now),

            buildTextPadding(text: 'Coming Soon', s: size),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Divider(
                thickness: 3,
                color: Colors.grey,
              ),
            ),
            BuildUpcoming(size: size, movie: comming),
            // const Padding(
            //   padding: EdgeInsets.only(top: 15, bottom: 10),
            //   child: Center(
            //     child: Text(
            //       'Continue Watching',
            //       style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white),
            //     ),
            //   ),
            // ),
            // Buildmoviestatic(popular: comming, size: size),
            BuildListMovie(
              size: size,
              movie: now,
              movie1: comming,
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTextPadding({required String text, required Size s}) {
    return Padding(
      padding: EdgeInsets.only(left: s.width / 2 - 50),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
