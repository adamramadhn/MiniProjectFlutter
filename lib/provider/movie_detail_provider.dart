import 'package:flutter/cupertino.dart';
import 'package:movie/model/movie_detail.dart';
import 'package:movie/repository/movie_repos.dart';

enum DetailStatus { none, loading, error }

class DetailMoviewProvider with ChangeNotifier {
  final MovieRepository movieAPI = MovieRepository();
  DetailStatus _status = DetailStatus.none;
  DetailStatus get status => _status;

  MovieDetail get movie => _movie;
  MovieDetail _movie =
       MovieDetail(0, 0, '', '', '', '', 0, '', [], [], 0, 0, '', 0);

  changeStatus(DetailStatus s) {
    _status = s;
  }

  getDetailMovie(int id) async {
    changeStatus(DetailStatus.loading);
    try {
      final d = await movieAPI.getMovieDetail(id);
      _movie = d.movieDetail;
      changeStatus(DetailStatus.none);
      notifyListeners();
    } catch (e) {
      changeStatus(DetailStatus.error);
      notifyListeners();
    }
  }
}
