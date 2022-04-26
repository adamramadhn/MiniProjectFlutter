import 'package:flutter/material.dart';
import 'package:movie/provider/popular_movie_provider.dart';
import 'package:movie/widgets/home_screen_widgets/popular_movies_widget/movie_list_horizontal.dart';
import 'package:provider/provider.dart';
import '../movie_widget_loader.dart';

class PopularMovieList extends StatefulWidget {
  const PopularMovieList({Key? key}) : super(key: key);

  @override
  State<PopularMovieList> createState() => _PopularMovieListState();
}

class _PopularMovieListState extends State<PopularMovieList> {
  @override
  void initState() {
    context.read<PopularMovieProvider>().getPopularMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PopularMovieProvider>();
    return Consumer<PopularMovieProvider>(
      builder: (context, value, child) {
        switch (state.state) {
          case PopMovieViewState.error:
            return const Center(child: Text('Oops something went wrong!'));
          case PopMovieViewState.none:
            if (state.popMovie.isEmpty) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: const <Widget>[
                        Text(
                          "No More Popular Movies",
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    )
                  ],
                ),
              );
            } else {
              return const PopMovieListHorizontal();
            }
          default:
            return buildMovielistLoaderWidget(context);
        }
      },
    );
  }
}
