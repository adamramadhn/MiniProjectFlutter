import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:movie/screen/login_screen/login_screen.dart';
import 'package:movie/screen/profile_screen/profile_screen.dart';
import 'package:movie/widgets/container_opacity_widget/container_opacity_widget.dart';
import 'package:movie/widgets/error_handling_widget/error_handle_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/connectivity/connection_provider.dart';
import '../../widgets/home_screen_widgets/now_playing_widgets/now_playing_list.dart';
import '../../widgets/home_screen_widgets/popular_movies_widget/popular_movie_list.dart';
import '../../widgets/top_rated_movie_widgets/top_rated_movies_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences logindata;
  String id = '';
  bool notConnected = false;

  @override
  void initState() {
    getId();
    context.read<CheckConnectivityProvider>().initConnectivity();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<CheckConnectivityProvider>().initConnectivity();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CheckConnectivityProvider>(context).connectivityState;
    checkConnection();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                if (!notConnected) {
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
                }
              },
              icon: const Icon(
                FontAwesome5.sign_out_alt,
              )),
          title: Text('Nobarin', style: Theme.of(context).textTheme.bodyText1),
          centerTitle: true,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    icon: const Icon(FontAwesome5.person_booth),
                    onPressed: () {
                      if (!notConnected) {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
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
                      }
                    }))
          ]),
      body: ListView(
        children: <Widget>[
          if (notConnected)
            Stack(
              children: [
                const ErrorHandleWidget(),
                containerOpacityWidget(context,Colors.black, Colors.black, 0.8, 0.4),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Text('Please Check Your Connectivity..'),
                  ),
                ),
              ],
            ),
          if (!notConnected) title('Sedang Tayang'),
          if (!notConnected) const NowPlayingList(),
          if (!notConnected) title('Populer'),
          const PopularMovieList(),
          if (!notConnected) title('Top Rated'),
          if (!notConnected) const TopRatedMovieList(),
        ],
      ),
    );
  }

  Widget title(String judul) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(judul, style: Theme.of(context).textTheme.bodyText2),
    );
  }

  getId() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      id = logindata.getString('idProfile') ?? 'null';
    });
  }

  checkConnection() {
    final _connectionStatus =
        Provider.of<CheckConnectivityProvider>(context).connectivityState;
    if (_connectionStatus != ConnectivityResult.none) {
      setState(() {
        notConnected = false;
      });
    } else {
      setState(() {
        notConnected = true;
      });
    }
  }
}
