import 'package:flutter/cupertino.dart';
import 'package:movie/model/movie.dart';
import 'package:movie/repository/movie_repos.dart';

enum PopMovieViewState {
  none,
  loading,
  error,
}

class PopularMovieProvider with ChangeNotifier {
  final MovieRepository movieAPI = MovieRepository();
  PopMovieViewState _state = PopMovieViewState.none;
  PopMovieViewState get state => _state;

  List<Movie> _popMovie = [];
  List<Movie> get popMovie => _popMovie;

  changeState(PopMovieViewState s) {
    _state = s;
  }
  getPopularMovie() async {
    changeState(PopMovieViewState.loading);
    try {
      final d = await movieAPI.getPopuparMovies(1);
      _popMovie = d.movies;
      changeState(PopMovieViewState.none);
      notifyListeners();
    } catch (e) {
      changeState(PopMovieViewState.error);
      notifyListeners();
    }
  }
}
