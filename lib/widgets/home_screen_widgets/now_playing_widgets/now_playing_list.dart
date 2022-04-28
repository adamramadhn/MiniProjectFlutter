import 'package:flutter/material.dart';
import 'package:movie/provider/now_playing_provider.dart';
import 'package:movie/widgets/home_screen_widgets/now_playing_widgets/movie_list_horizontal.dart';
import 'package:movie/widgets/home_screen_widgets/movie_widget_loader.dart';
import 'package:provider/provider.dart';

class NowPlayingList extends StatefulWidget {
  const NowPlayingList({Key? key}) : super(key: key);

  @override
  State<NowPlayingList> createState() => _NowPlayingListState();
}

class _NowPlayingListState extends State<NowPlayingList> {
  @override
  void initState() {
    context.read<NowPlayingProvider>().getNowPlaying();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final state = context.watch<NowPlayingProvider>();
    return Consumer<NowPlayingProvider>(
      builder: (context, value, child) {
        switch (value.state) {
          case MovieViewState.error:
            return const Center(child: Text('Oops something went wrong!'));
          case MovieViewState.none:
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
                          "No More Playing Movies",
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    )
                  ],
                ),
              );
            } else {
              return const MovieListHorizontal();
            }
          default:
            return buildMovielistLoaderWidget(context);
        }
      },
    );
  }
}
