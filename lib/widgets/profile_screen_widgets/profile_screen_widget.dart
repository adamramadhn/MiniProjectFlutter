import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

import '../../provider/profile_provider.dart';
import '../../repository/profile.dart';

class ProfileScreenWidget extends StatefulWidget {
  const ProfileScreenWidget(
      {Key? key,
      required this.id,
      required this.teks,
      required this.background})
      : super(key: key);
  final String id;
  final Color teks;
  final Color background;

  @override
  State<ProfileScreenWidget> createState() => _ProfileScreenWidgetState();
}

class _ProfileScreenWidgetState extends State<ProfileScreenWidget> {
  bool isUpdate = false;
  var txtNama = TextEditingController();
  var txtNoHp = TextEditingController();
  @override
  void initState() {
    context.read<ProfileProvider>().getProfileData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProfile = context.watch<ProfileProvider>().profileData;
    return SafeArea(
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width * 0.8,
          child: ListView(children: [
            if (dataProfile.avatar != null)
              CircleAvatar(
                backgroundImage: NetworkImage(dataProfile.avatar!),
                radius: 100,
              ),
            spasi(20.0),
            //teks nama
            if (!isUpdate)
              Center(
                  child: Text(
                dataProfile.nama ?? 'Something wrong..',
                style: TextStyle(
                  fontSize: 24,
                  color: widget.teks,
                  fontFamily: 'OpenSans',
                ),
              )),
            spasi(10),
            //teks nohp
            if (!isUpdate)
              Center(
                  child: Text(
                dataProfile.nohp ?? 'Something wrong..',
                style: TextStyle(
                  fontSize: 24,
                  color: widget.teks,
                  fontFamily: 'OpenSans',
                ),
              )),
            spasi(10),
            //Input Nama
            if (isUpdate)
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.teks),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  enabled: isUpdate,
                  autofocus: true,
                  controller: txtNama,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(FontAwesome5.id_card, color: widget.background),
                    hintText: dataProfile.nama ?? 'Nothings Found..',
                  ),
                  style: TextStyle(
                      color: widget.background,
                      fontFamily: 'OpenSans',
                      fontSize: 24),
                ),
              ),
            spasi(10),
            //Input No Hp
            if (isUpdate)
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.teks),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  enabled: isUpdate,
                  controller: txtNoHp,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon:
                          Icon(FontAwesome5.phone, color: widget.background),
                      hintText: dataProfile.nohp ?? 'Nothings Found..'),
                  style: TextStyle(
                      color: widget.background,
                      fontFamily: 'OpenSans',
                      fontSize: 24),
                ),
              ),
            spasi(30.0),
            if (!isUpdate)
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => widget.teks)),
                  onPressed: () {
                    setState(() {
                      isUpdate = !isUpdate;
                    });
                  },
                  child: Text(
                    'Update Profile',
                    style: TextStyle(color: widget.background),
                  )),
            if (isUpdate)
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.green)),
                  onPressed: () {
                    if (dataProfile.id != null) {
                      setState(() {
                        String? newName, newPhone;
                        if (txtNama.text.isEmpty) {
                          newName = dataProfile.nama!;
                        } else {
                          newName = txtNama.text;
                        }
                        if (txtNoHp.text.isEmpty) {
                          newPhone = dataProfile.nohp!;
                        } else {
                          newPhone = txtNoHp.text;
                        }
                        update(dataProfile.id!, newName, newPhone);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Berhasil di Update')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('ID Tidak ditemukan..')));
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: widget.background),
                  )),
            if (isUpdate)
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey)),
                  onPressed: () {
                    setState(() {
                      isUpdate = !isUpdate;
                    });
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: widget.background),
                  )),
          ]),
        ),
      ),
    );
  }

  Widget spasi(double h) {
    return SizedBox(
      height: h,
    );
  }

  update(String id, String nama, String nohp) async {
    await ProfileApi().updateProfile(id, nama, nohp);
    setState(() {
      isUpdate = !isUpdate;
    });
    context.read<ProfileProvider>().getProfileData(widget.id);
  }
}
