import 'package:dangnhap/views/HomePage/Widgets/BuildMovie.dart';
import 'package:dangnhap/views/HomePage/Widgets/BuildMovieStatic.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
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
  late Future<List<Movie2>> movie;
  late Future<List<Movie2>> popular;
  late Future<List<Movie2>> toprate;
  ApiService fetmovie = ApiService();
  late FlickManager flickManager;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    movie = fetmovie.fetchMovies();
    popular = fetmovie.Upcoming();
    toprate = fetmovie.Toprate();
    _controller = YoutubePlayerController(
      initialVideoId: 'c75XRkb2MpQ',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    // flickManager = FlickManager(
    //     videoPlayerController: VideoPlayerController.networkUrl(
    //         Uri.parse('https://youtu.be/c75XRkb2MpQ')));
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
          const SizedBox(height: 100),
          const UserHome(),
          // YoutubePlayer(
          //   controller: _controller,
          //   showVideoProgressIndicator: true,
          //   progressIndicatorColor: Colors.cyan,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 40, bottom: 20),
          //   child: Center(
          //     child: Container(
          //       width: 300,
          //       child: AspectRatio(
          //           aspectRatio: 16 / 8,
          //           child: FlickVideoPlayer(flickManager: flickManager)),
          //     ),
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.only(left: 35, top: 15, bottom: 10),
            child: Text(
              'New release',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Buildmovie(popular: popular, size: size),
          const Padding(
            padding: EdgeInsets.only(left: 5, top: 15, bottom: 10),
            child: Text(
              'Up Coming',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          BuildUpcoming(size: size, movie: movie),
          const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 10),
            child: Center(
              child: Text(
                'Continue Watching',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Buildmoviestatic(popular: toprate, size: size),
          BuildListMovie(size: size, movie: movie),
        ],
      ),
    );
  }
}
