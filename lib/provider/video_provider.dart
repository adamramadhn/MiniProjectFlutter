import 'package:flutter/cupertino.dart';
import 'package:movie/repository/movie_repos.dart';

class VideoProvider with ChangeNotifier {
  final MovieRepository movieAPI = MovieRepository();
  String _video = '';
  String get videoTrailer => _video;

  getVideoTrailer(int id) async {
    try {
      final d = await movieAPI.getVideo(id);
      _video = d.results![0].key!;
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
