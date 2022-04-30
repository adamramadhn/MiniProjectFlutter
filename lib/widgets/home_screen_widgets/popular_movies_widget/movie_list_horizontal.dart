import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:movie/provider/popular_movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../screen/movie_detail_screen/movie_detail_screen.dart';

class PopMovieListHorizontal extends StatelessWidget {
  const PopMovieListHorizontal({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final movies = Provider.of<PopularMovieProvider>(context).popMovie;
    return SizedBox(
      height: 180.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 8.0, top: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return MovieDetailScreen(
                        movieId: movies[index].id,
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
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Stack(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.black87,
                          highlightColor: Colors.white54,
                          enabled: true,
                          child: const SizedBox(
                            height: 160.0,
                            child: AspectRatio(
                                aspectRatio: 2 / 3,
                                child: Icon(
                                  FontAwesome5.film,
                                  color: Colors.black26,
                                  size: 40.0,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 160.0,
                          child: AspectRatio(
                              aspectRatio: 2 / 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: FadeInImage.memoryNetwork(
                                    fit: BoxFit.cover,
                                    placeholder: kTransparentImage,
                                    image: "https://image.tmdb.org/t/p/w300/" +
                                        movies[index].poster),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
