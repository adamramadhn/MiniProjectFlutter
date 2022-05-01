import 'package:flutter/material.dart';
import 'package:movie/provider/top_rated_movie_provider.dart';
import 'package:movie/widgets/home_screen_widgets/movie_widget_loader.dart';
import 'package:movie/widgets/top_rated_movie_widgets/top_rated_list.dart';
import 'package:provider/provider.dart';

class TopRatedMovieList extends StatefulWidget {
  const TopRatedMovieList({Key? key}) : super(key: key);

  @override
  State<TopRatedMovieList> createState() => _TopRatedMovieListState();
}

class _TopRatedMovieListState extends State<TopRatedMovieList> {
  @override
  void initState() {
    context.read<TopRatedMovieProvider>().getTopRated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TopRatedMovieProvider>(
      builder: (context, value, child) {
        switch (value.state) {
          case TopRatedMovieState.error:
            return const Center(child: Text('Oops something went wrong!'));
          case TopRatedMovieState.none:
            if (value.movie.isEmpty) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: const <Widget>[
                        Text(
                          "No More Top Rated Movies",
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    )
                  ],
                ),
              );
            } else {
              return const TopRatedListWidget();
            }
          default:
            return buildMovielistLoaderWidget(context);
        }
      },
    );
  }
}
