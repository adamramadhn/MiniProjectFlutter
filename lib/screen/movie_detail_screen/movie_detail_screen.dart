import 'package:flutter/material.dart';
import 'package:movie/widgets/movie_detail_widgets/movie_detail_view.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);
  final int movieId;
  @override
  Widget build(BuildContext context) {
    Color warna = Colors.black;
    return Scaffold(
      backgroundColor: warna,
      body: MovieDetailView(
        movieId: movieId,
      ),
    );
  }
}
