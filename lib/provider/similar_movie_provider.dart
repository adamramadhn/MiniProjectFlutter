import 'package:flutter/cupertino.dart';

import '../model/movie.dart';
import '../repository/movie_repos.dart';

enum SimilarMovieState{
  none,
  loading,
  error,
}

class SimilarMovieProvider with ChangeNotifier{
  final MovieRepository movieAPI = MovieRepository();
  SimilarMovieState _state = SimilarMovieState.none;
  SimilarMovieState get state => _state;

  List<Movie> _movie = [];
  List<Movie> get similarMovie => _movie;

  changeState(SimilarMovieState s) {
    _state = s;
  }

  getSimilarMovies(int movieId)async{
 changeState(SimilarMovieState.loading);
    try {
      final d = await movieAPI.getSimilarMovies(movieId);
      _movie = d.movies;
      changeState(SimilarMovieState.none);
      notifyListeners();
    } catch (e) {
      changeState(SimilarMovieState.error);
      notifyListeners();
    }
  }
}