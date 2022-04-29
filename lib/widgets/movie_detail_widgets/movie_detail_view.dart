import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/provider/movie_detail_provider.dart';
import 'package:movie/widgets/movie_detail_widgets/movie_cast_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'cast_widget_loader.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({Key? key, required this.movieId}) : super(key: key);
  final int movieId;

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  void initState() {
    context.read<DetailMoviewProvider>().getDetailMovie(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat();
    return Consumer<DetailMoviewProvider>(builder: (context, value, child) {
      switch (value.status) {
        case DetailStatus.error:
          return const Center(
              child: Text(
            'Oops something went wrong!',
            style: TextStyle(color: Colors.white),
          ));
        case DetailStatus.none:
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.white54,
                            child: AspectRatio(
                                aspectRatio: 3 / 2,
                                child: Container(
                                    decoration: const BoxDecoration(
                                  color: Colors.black12,
                                ))),
                          ),
                          AspectRatio(
                              aspectRatio: 3 / 2,
                              child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: kTransparentImage,
                                  image:
                                      "https://image.tmdb.org/t/p/original/" +
                                          value.movie.backPoster)),
                        ],
                      ),
                      AspectRatio(
                        aspectRatio: 3 / 2,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.2),
                                Colors.black.withOpacity(1.0)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0, 1],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0.0,
                          left: 10.0,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.white10,
                                      highlightColor: Colors.white30,
                                      enabled: true,
                                      child: SizedBox(
                                        height: 120.0,
                                        child: AspectRatio(
                                            aspectRatio: 2 / 3,
                                            child: Container(
                                                decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Colors.black12,
                                            ))),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      height: 120.0,
                                      child: AspectRatio(
                                          aspectRatio: 2 / 3,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                image:
                                                    "https://image.tmdb.org/t/p/w200/" +
                                                        value.movie.poster),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 140,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        value.movie.title,
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Release date: " +
                                                value.movie.releaseDate,
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                        left: 5.0,
                        child: SafeArea(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  EvaIcons.arrowIosBack,
                                  size: 25.0,
                                  color: Colors.white,
                                ))),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            EvaIcons.clockOutline,
                            size: 15.0,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            getDuration(value.movie.runtime),
                            style: const TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 40.0,
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: value.movie.genres.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(30.0)),
                                            color:
                                                Colors.white.withOpacity(0.1)),
                                        child: Text(
                                          value.movie.genres[index].name,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              height: 1.4,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 9.0),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text("OVERVIEW",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white.withOpacity(0.5))),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(value.movie.overview,
                          style: const TextStyle(
                            color: Colors.white,
                            height: 1.5,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.05)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("CASTS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white.withOpacity(0.5))),
                      const SizedBox(
                        height: 10.0,
                      ),
                      MovieCastView(
                        movieId: widget.movieId,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("ABOUT MOVIE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.white.withOpacity(0.5))),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Status:",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white.withOpacity(0.5))),
                          Text(value.movie.status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Budget:",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white.withOpacity(0.5))),
                          Text(
                              "\$" +
                                  currencyFormatter.format(value.movie.budget),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Revenue:",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white.withOpacity(0.5))),
                          Text(
                              "\$" +
                                  currencyFormatter.format(value.movie.revenue),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 20.0,
                // ),
                // Container(
                //   decoration:
                //       BoxDecoration(color: Colors.white.withOpacity(0.05)),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                //         child: Text("SIMILAR MOVIES",
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 14.0,
                //                 color: Colors.white.withOpacity(0.5))),
                //       ),
                //       const SizedBox(
                //         height: 10.0,
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 2.0),
                //         child: RepositoryProvider.value(
                //           value: movieRepository,
                //           child: SimilarMoviesWidget(
                //             movieId: movieId,
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 20.0,
                // ),
              ],
            ),
          );
        default:
          return buildCastslistLoaderWidget(context);
      }
    });
  }

  String getDuration(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}min';
  }
}
