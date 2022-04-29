class ProfileData {
  String? avatar;
  String? nama;
  String? nohp;
  String? email;
  String? password;
  String? id;

  ProfileData(
      {this.avatar, this.nama, this.nohp, this.email, this.password, this.id});

  ProfileData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    nama = json['nama'];
    nohp = json['nohp'];
    email = json['email'];
    password = json['password'];
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
    return data;
  }
}
