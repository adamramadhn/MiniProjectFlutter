import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:movie/provider/similar_movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../screen/movie_detail_screen/movie_detail_screen.dart';
import '../home_screen_widgets/movie_widget_loader.dart';

class SimilarMovieView extends StatefulWidget {
  const SimilarMovieView({Key? key, required this.movieId}) : super(key: key);
  final int movieId;
  @override
  State<SimilarMovieView> createState() => _SimilarMovieViewState();
}

class _SimilarMovieViewState extends State<SimilarMovieView> {
  @override
  void initState() {
    context.read<SimilarMovieProvider>().getSimilarMovies(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SimilarMovieProvider>(builder: (context, value, child) {
      switch (value.state) {
        case SimilarMovieState.error:
          return const Center(
              child: Text(
            'Oops something went wrong!',
            style: TextStyle(color: Colors.white),
          ));
        case SimilarMovieState.none:
          return SizedBox(
            height: 170.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: value.similarMovie.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                              movieId: value.similarMovie[index].id),
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
                                          image:
                                              "https://image.tmdb.org/t/p/w300/" +
                                                  value.similarMovie[index]
                                                      .poster),
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
        default:
          return buildMovielistLoaderWidget(context);
      }
    });
  }
}
