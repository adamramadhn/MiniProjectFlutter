import 'package:dio/dio.dart';
import 'package:movie/model/profile.dart';

class AuthUser {
  final String mainUrl =
      "https://626802927863833642288be2.mockapi.io/api/v1/profile";
  final Dio _dio = Dio();

  Future<ProfileData> login(String email, String password) async {
    var data = {"email": email, "password": password};
    try {
      Response response = await _dio.get(mainUrl, queryParameters: data);
      return ProfileData.fromJson(response.data[0]);
    } catch (e) {
      return ProfileData.fromJson({});
    }
  }

  Future<ProfileData> register(String email, String password, String ava,
      String nama, String nohp) async {
    var d = {
      "email": email,
      "password": password,
      "avatar": ava,
      "nama": nama,
      "nohp": nohp,
      // "favorite":[],
    };
    try {
      Response response = await _dio.post(mainUrl, data: d);
      return ProfileData.fromJson(response.data);
    } catch (e) {
      return ProfileData.fromJson({});
    }
  }
}
