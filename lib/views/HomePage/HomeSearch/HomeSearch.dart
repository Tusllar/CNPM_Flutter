import 'package:flutter/material.dart';

import '../../../main.dart';

class SearchMovie extends StatelessWidget {
  const SearchMovie({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      child: SizedBox(
        child: Row(children: [
          Expanded(
              child: Container(
            height: size.height / 15,
            decoration: BoxDecoration(
              color: DarkTheme.colorSearch,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Icon(
                    Icons.saved_search,
                    color: DarkTheme.white,
                  ),
                ),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Movie',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.mic,
                    color: DarkTheme.white,
                  ),
                ),
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
