import 'package:flutter/material.dart';
import 'package:movie/provider/now_playing_provider.dart';
import 'package:movie/provider/popular_movie_provider.dart';
import 'package:movie/screen/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NowPlayingProvider()),
      ChangeNotifierProvider(create: (_) => PopularMovieProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nobarin',
      home: HomeScreen(),
    );
  }
}
