import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:movie/provider/now_playing_provider.dart';
import 'package:movie/screen/movie_detail_screen/movie_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieListHorizontal extends StatelessWidget {
  const MovieListHorizontal({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final movies = Provider.of<NowPlayingProvider>(context).movie;
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
                    MaterialPageRoute(
                      builder: (context) =>  MovieDetailScreen(movieId: movies[index].id,),
                    ));
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
