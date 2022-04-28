import 'package:flutter/cupertino.dart';
import 'package:movie/repository/movie_repos.dart';

import '../model/cast.dart';

enum CastStatus { none, loading, error }

class MovieCastProvider with ChangeNotifier {
  final MovieRepository movieAPI = MovieRepository();
  CastStatus _status = CastStatus.none;
  CastStatus get status => _status;

  List<Cast> _casts = [];
  List<Cast> get cast => _casts;

  changeStatus(CastStatus s) {
    _status = s;
  }

  getCasterMovie(int id) async {
    changeStatus(CastStatus.loading);
    try {
      final d = await movieAPI.getCasts(id);
      _casts = d.casts;
      changeStatus(CastStatus.none);
      notifyListeners();
    } catch (e) {
      changeStatus(CastStatus.error);
      notifyListeners();
    }
  }
}
