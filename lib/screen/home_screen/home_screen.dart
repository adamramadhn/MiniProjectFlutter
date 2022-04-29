import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:movie/screen/login_screen/login_screen.dart';
import 'package:movie/screen/profile_screen/profile_screen.dart';
import 'package:movie/widgets/home_screen_widgets/now_playing_widgets/now_playing_list.dart';
import 'package:movie/widgets/home_screen_widgets/popular_movies_widget/popular_movie_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences logindata;
  String id = '';
  @override
  void initState() {
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color warna = Colors.black;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: warna,
          leading: IconButton(
              onPressed: () async {
                logindata = await SharedPreferences.getInstance();
                logindata.setBool('newUser', true);
                Navigator.of(context).pushAndRemoveUntil(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const LoginScreen();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final tween = Tween(begin: 0.0, end: 1.0);
                        return FadeTransition(
                          opacity: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                    (route) => false);
                logindata.remove('idProfile');
              },
              icon: const Icon(FontAwesome5.sign_out_alt)),
          title: const Text(
            'Nobarin',
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
                    icon: const Icon(FontAwesome5.person_booth),
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return ProfileScreen(id: id);
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final tween = Tween(begin: 0.0, end: 1.0);
                          return FadeTransition(
                            opacity: animation.drive(tween),
                            child: child,
                          );
                        },
                      ));
                    }))
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

  getId() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      id = logindata.getString('idProfile') ?? 'null';
    });
  }
}
