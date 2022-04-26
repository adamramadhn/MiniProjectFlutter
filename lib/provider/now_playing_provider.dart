import 'package:flutter/cupertino.dart';
import 'package:movie/model/movie.dart';
import 'package:movie/repository/movie_repos.dart';

enum MovieViewState {
  none,
  loading,
  error,
}

class NowPlayingProvider with ChangeNotifier {
  final MovieRepository movieAPI = MovieRepository();
  MovieViewState _state = MovieViewState.none;
  MovieViewState get state => _state;

  List<Movie> _movie = [];
  List<Movie> get movie => _movie;

  changeState(MovieViewState s) {
    _state = s;
  }

  getNowPlaying() async {
    changeState(MovieViewState.loading);
    try {
      final d = await movieAPI.getNowPlaying(1);
      _movie = d.movies;
      changeState(MovieViewState.none);
      notifyListeners();
    } catch (e) {
      changeState(MovieViewState.error);
      notifyListeners();
    }
  }
}
