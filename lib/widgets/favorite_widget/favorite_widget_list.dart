import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/favorite_provider.dart';
import '../../provider/profile_provider.dart';
import '../../screen/movie_detail_screen/movie_detail_screen.dart';

class FavoriteWidgetList extends StatefulWidget {
  const FavoriteWidgetList({Key? key, required this.profileId})
      : super(key: key);
  final String profileId;
  @override
  State<FavoriteWidgetList> createState() => _FavoriteWidgetListState();
}

class _FavoriteWidgetListState extends State<FavoriteWidgetList> {
  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false)
        .getProfileData(widget.profileId);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.watch<FavoriteProvider>().getFavMovie;
    context.read<FavoriteProvider>().getFavorite(widget.profileId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final favMovies =
        Provider.of<FavoriteProvider>(context, listen: false).getFavMovie;
    final favMoviesId =
        Provider.of<FavoriteProvider>(context, listen: false).getFavId;
    return Stack(
      children: [
        if (favMoviesId.isEmpty)
          const Center(
            child: Text('Empty'),
          ),
        if (favMoviesId.isNotEmpty)
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return MovieDetailScreen(
                              movieId: int.parse(favMoviesId[index].toString()),
                              profileId: widget.profileId,
                            );
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
                  },
                  child: ListTile(
                    textColor: Colors.white,
                    title: Text(favMovies[index]),
                  ),
                );
              },
              itemCount: favMovies.length,
            ),
          ),
      ],
    );
  }
}
