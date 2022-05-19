import 'package:flutter/cupertino.dart';
import 'package:movie/repository/profile.dart';

class FavoriteProvider with ChangeNotifier {
  final ProfileApi movieAPI = ProfileApi();

  List _getfavMovie = [];
  List get getFavMovie => _getfavMovie;

  List _getfavId = [];
  List get getFavId => _getfavId;

  addFavorite(String id, String title, int favId) async {
    try {
      getFavorite(id);
      _getfavMovie.add(title);
      _getfavId.add(favId);
      await ProfileApi().addFavorite(id, _getfavMovie, _getfavId);
      getFavorite(id);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  removeFavorite(String id, String title, int favId) async {
    try {
      _getfavMovie.remove(title);
      _getfavId.remove(favId);
      await ProfileApi().addFavorite(id, _getfavMovie, _getfavId);
      notifyListeners();
      getFavorite(id);
    } catch (e) {
      notifyListeners();
    }
  }

  getFavorite(String profileId) async {
    try {
      final d = await ProfileApi().getProfile(profileId);
      _getfavMovie = d.favorite!;
      _getfavId = d.favId!;
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  clearAllFavorite(String id) async {
    try {
      _getfavId.clear();
      _getfavMovie.clear();
      await ProfileApi().addFavorite(id, _getfavMovie, _getfavId);
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
