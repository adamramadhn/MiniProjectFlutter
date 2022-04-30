import 'package:flutter/cupertino.dart';
import 'package:movie/model/movie.dart';
import 'package:movie/repository/movie_repos.dart';

enum TopRatedMovieState {
  none,
  loading,
  error,
}

class TopRatedMovieProvider with ChangeNotifier {
  final MovieRepository movieAPI = MovieRepository();
  TopRatedMovieState _state = TopRatedMovieState.none;
  TopRatedMovieState get state => _state;

  List<Movie> _movie = [];
  List<Movie> get movie => _movie;

  changeState(TopRatedMovieState s) {
    _state = s;
  }

  getTopRated() async {
    changeState(TopRatedMovieState.loading);
    try {
      final d = await movieAPI.getTopRatedMovies();
      _movie = d.movies;
      changeState(TopRatedMovieState.none);
      notifyListeners();
    } catch (e) {
      changeState(TopRatedMovieState.error);
      notifyListeners();
    }
  }
}
