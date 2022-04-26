import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:movie/widgets/home_screen_widgets/now_playing_widgets/now_playing_list.dart';
import 'package:movie/widgets/home_screen_widgets/popular_movies_widget/popular_movie_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color warna = Colors.black;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: warna,
          leading: const Icon(Icons.person),
          title: const Text(
            'NobariN',
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 28),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  icon: const Icon(FontAwesome5.bookmark),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Bookmark diklik!')));
                  }),
            )
          ]),
      body: Container(
        color: warna,
        child: ListView(
          children: [
            title('Sedang Tayang'),
            const NowPlayingList(),
            title('Populer'),
            const PopularMovieList(),
          ],
        ),
      ),
    );
  }

  Widget title(String judul) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        judul,
        style: const TextStyle(
            fontSize: 24,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }
}
