import 'package:dangnhap/views/HomePage/Widgets/BuildMovie.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../controller/APIservice/ApiService.dart';
import '../../models/data.dart';
import 'Widgets/BuildListMovie.dart';
import 'Widgets/BuildUpcoming.dart';
import 'Widgets/UserHome.dart';

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

  @override
  void initState() {
    super.initState();
    now = fetmovie.Nowplay();
    comming = fetmovie.Comming();
    print(now);
    print(comming);

    _controller = YoutubePlayerController(
      initialVideoId: 'J5t6ypmbMKg',
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const UserHome(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.cyan,
            ),
          ),
          buildPadding(text: 'Now Playing'),
          Buildmovie(popular: comming, size: size),
          buildPadding(text: 'Coming Soon'),
          BuildUpcoming(size: size, movie: now),
          buildPadding(text: 'Now Playing'),
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
    );
  }

  Padding buildPadding({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, top: 15, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
