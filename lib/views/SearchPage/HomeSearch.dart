import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../controller/APIservice/ApiService.dart';
import '../../main.dart';
import '../../models/data.dart';
import 'Widget/BuildTitle.dart';
import 'Widget/ListMovie.dart';

class Homesearch extends StatefulWidget {
  const Homesearch({
    super.key,
  });

  @override
  State<Homesearch> createState() => _HomesearchState();
}

class _HomesearchState extends State<Homesearch> {
  late Future<List<Movie2>> comming;
  late Future<List<Movie2>> toprate;
  ApiService fetmovie = ApiService();
  late Future<List<Movie2>> now;
  ApiService apiService = ApiService();
  late Future<List<Movie2>> movie;
  bool key = false;
  final TextEditingController _searchController = TextEditingController();

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _wordsSpoken = "";
  double _confidenceLevel = 0;

  @override
  void initState() {
    super.initState();
    comming = fetmovie.Comming();
    toprate = fetmovie.Toprate();
    now = fetmovie.Nowplay();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult, localeId: 'vi_VN');
    setState(() {
      _confidenceLevel = 0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;
      _searchController.text = _wordsSpoken;
      // Tự động tìm kiếm khi nhận được kết quả giọng nói
      movie = apiService.SearchMovie(_wordsSpoken);
      key = !key;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 100, left: 20, right: 20, bottom: 10),
            child: SizedBox(
              child: Row(children: [
                Expanded(
                    child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: DarkTheme.colorSearch,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Icon(
                          Icons.saved_search,
                          color: DarkTheme.white,
                        ),
                      ),
                      Expanded(
                          child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            key = value.isNotEmpty;
                            movie = apiService.SearchMovie(value);
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Tìm kiếm phim',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: GestureDetector(
                          onTap: () {
                            if (_speechToText.isListening) {
                              _stopListening();
                            } else {
                              _startListening();
                              _searchController.clear();
                            }
                          },
                          child: Icon(
                            _speechToText.isNotListening
                                ? Icons.mic_off
                                : Icons.mic,
                            color: DarkTheme.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ]),
            ),
          ),
          if (key) ...[
            const BuildTitle(Title: "Phim tìm kiếm"),
            ListMovie(movie: movie),
          ] else ...[
            const BuildTitle(Title: "Phim đang chiếu"),
            const SizedBox(height: 20),
            ListMovie(movie: now),
            const BuildTitle(Title: "Phim sắp ra mắt"),
            ListMovie(movie: comming),
          ]
        ],
      ),
    );
  }
}
