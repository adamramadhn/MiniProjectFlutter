import 'package:dio/dio.dart';
import 'package:movie/model/profile.dart';
import 'package:movie/model/random_image_response.dart';

class ProfileApi {
  final String mainUrl =
      "https://626802927863833642288be2.mockapi.io/api/v1/profile";
  final Dio _dio = Dio();

  Future<ProfileData> getProfile(String id) async {
    var params = {"id": id};
    try {
      Response response = await _dio.get(mainUrl, queryParameters: params);

      return ProfileData.fromJson(response.data[0]);
    } catch (e) {
      return ProfileData.fromJson({});
    }
  }

  updateProfile(String id, String nama, String nohp) async {
    var params = {"nama": nama, "nohp": nohp};
    try {
      await _dio.put(mainUrl + '/$id', data: params);
    } catch (e) {
      return ProfileData.fromJson({});
    }
  }

  Future<RandomImageApi> getImageRandom() async {
    try {
      Response response = await _dio.get(
          'https://api.unsplash.com/photos/random?client_id=9Ci5WNtXIa_syV_2NiL0m4xPy7e188B2ojlhnbEvb1E');
      return RandomImageApi.fromJson(response.data);
    } catch (e) {
      return RandomImageApi.fromJson({});
    }
  }
}
