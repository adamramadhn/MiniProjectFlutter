import 'package:flutter/material.dart';
import 'package:movie/provider/movie_cast_provider.dart';
import 'package:movie/provider/movie_detail_provider.dart';
import 'package:movie/provider/now_playing_provider.dart';
import 'package:movie/provider/popular_movie_provider.dart';
import 'package:movie/provider/profile_provider.dart';
import 'package:movie/screen/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NowPlayingProvider()),
      ChangeNotifierProvider(create: (_) => PopularMovieProvider()),
      ChangeNotifierProvider(create: (_) => MovieCastProvider()),
      ChangeNotifierProvider(create: (_) => DetailMoviewProvider()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nobarin',
      home: LoginScreen(),
    );
  }
}
