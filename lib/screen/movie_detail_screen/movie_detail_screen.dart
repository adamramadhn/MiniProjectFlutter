import 'package:flutter/material.dart';
import 'package:movie/widgets/movie_detail_widgets/movie_detail_view.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen(
      {Key? key, required this.movieId, required this.profileId})
      : super(key: key);
  final int movieId;
  final String profileId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovieDetailView(
        movieId: movieId,
        profileId: profileId,
      ),
    );
  }
}
