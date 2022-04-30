import 'package:flutter/material.dart';
import 'package:movie/widgets/profile_screen_widgets/profile_screen_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    Color teks = Colors.white;
    Color background = Colors.black;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: background,
      ),
      backgroundColor: background,
      body: ProfileScreenWidget(id: id, teks: teks, background: background),
    );
  }
}
