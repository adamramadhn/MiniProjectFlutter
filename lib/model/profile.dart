class ProfileData {
  String? avatar;
  String? nama;
  String? nohp;
  String? email;
  String? password;
  String? id;
  List? favorite;
  List? favId;

  ProfileData({
    this.avatar,
    this.nama,
    this.nohp,
    this.email,
    this.password,
    this.id,
    this.favorite,
    this.favId,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    nama = json['nama'];
    nohp = json['nohp'];
    email = json['email'];
    password = json['password'];
    if (json['favorite'] != null) {
      favorite = [];
      json['favorite'].forEach((v) {
        favorite!.add(v);
      });
    }
    if (json['favId'] != null) {
      favId = [];
      json['favId'].forEach((v) {
        favId!.add(v);
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['nama'] = nama;
    data['nohp'] = nohp;
    data['email'] = email;
    data['password'] = password;
    data['id'] = id;
    if (favorite != null) {
      data['favorite'] = favorite!.map((v) => v.toJson()).toList();
    }
    if (favId != null) {
      data['favId'] = favId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
