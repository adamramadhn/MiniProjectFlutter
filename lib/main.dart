import 'package:flutter/material.dart';
import 'package:movie/provider/connectivity/connection_provider.dart';
import 'package:movie/provider/movie_cast_provider.dart';
import 'package:movie/provider/movie_detail_provider.dart';
import 'package:movie/provider/now_playing_provider.dart';
import 'package:movie/provider/popular_movie_provider.dart';
import 'package:movie/provider/profile_provider.dart';
import 'package:movie/provider/similar_movie_provider.dart';
import 'package:movie/provider/top_rated_movie_provider.dart';
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
      ChangeNotifierProvider(create: (_) => SimilarMovieProvider()),
      ChangeNotifierProvider(create: (_) => TopRatedMovieProvider()),
      ChangeNotifierProvider(create: (_) => CheckConnectivityProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nobarin',
      darkTheme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        appBarTheme: const AppBarTheme(color: Colors.black),
        scaffoldBackgroundColor: Colors.black,

        // Define the default font family.
        fontFamily: 'OpenSans',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyText2: TextStyle(fontSize: 24.0, color: Colors.white),
          // bodySmall: const TextStyle(
          //     fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold),
          button: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme(color: Colors.grey[900]),
        scaffoldBackgroundColor: Colors.grey[900],

        // Define the default font family.
        fontFamily: 'OpenSans',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyText2: TextStyle(fontSize: 24.0, color: Colors.white),
          // bodySmall: const TextStyle(
          //     fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold),
          button: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
