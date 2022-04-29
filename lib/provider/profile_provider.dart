import 'package:flutter/cupertino.dart';
import 'package:movie/model/profile.dart';
import 'package:movie/repository/profile.dart';

enum ProfileState {
  none,
  loading,
  error,
}

class ProfileProvider with ChangeNotifier {
  ProfileState _state = ProfileState.none;
  ProfileState get state => _state;

  ProfileData _profileData = ProfileData();
  ProfileData get profileData => _profileData;

  changeStatus(ProfileState s) {
    _state = s;
  }

  getProfileData(String id) async {
    changeStatus(ProfileState.loading);
    try {
      final d = await ProfileApi().getProfile(id);
      _profileData = d;
      changeStatus(ProfileState.none);
      notifyListeners();
    } catch (e) {
      changeStatus(ProfileState.error);
      notifyListeners();
    }
  }
}
