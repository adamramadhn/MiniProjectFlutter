import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:movie/provider/movie_cast_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../home_screen_widgets/movie_widget_loader.dart';

class MovieCastView extends StatefulWidget {
  const MovieCastView({Key? key, required this.movieId}) : super(key: key);
  final int movieId;
  @override
  State<MovieCastView> createState() => _MovieCastViewState();
}

class _MovieCastViewState extends State<MovieCastView> {
  @override
  void initState() {
    context.read<MovieCastProvider>().getCasterMovie(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieCastProvider>(builder: (context, value, child) {
      switch (value.status) {
        case CastStatus.error:
          return const Center(
              child: Text(
            'Oops something went wrong!',
            style: TextStyle(color: Colors.white),
          ));
        case CastStatus.none:
          return SizedBox(
            height: 130.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: value.cast.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, right: 8.0),
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
                                height: 120.0,
                                child: AspectRatio(
                                    aspectRatio: 2 / 3,
                                    child: Icon(
                                      FontAwesome5.user_alt,
                                      color: Colors.black26,
                                      size: 40.0,
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 120.0,
                              child: Stack(
                                children: [
                                  AspectRatio(
                                      aspectRatio: 2 / 3,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: FadeInImage.memoryNetwork(
                                            fit: BoxFit.cover,
                                            placeholderErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  'assets/img/cast_placeholder.png',
                                                  fit: BoxFit.cover);
                                            },
                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  'assets/img/cast_placeholder.png',
                                                  fit: BoxFit.cover);
                                            },
                                            placeholder: kTransparentImage,
                                            image:
                                                "https://image.tmdb.org/t/p/w300/" +
                                                    value.cast[index].img),
                                      )),
                                  AspectRatio(
                                    aspectRatio: 2 / 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.2),
                                            Colors.black.withOpacity(0.5)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: const [0, 1],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 3.0,
                                      left: 3.0,
                                      right: 3.0,
                                      child: SizedBox(
                                        width: 80.0,
                                        child: Text(
                                          value.cast[index].name,
                                          style: const TextStyle(
                                              fontSize: 10.0,
                                              color: Colors.white),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
