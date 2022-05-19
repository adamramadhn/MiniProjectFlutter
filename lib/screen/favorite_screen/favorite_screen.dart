import 'package:flutter/material.dart';
import 'package:movie/provider/favorite_provider.dart';
import 'package:movie/widgets/favorite_widget/favorite_widget_list.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key, required this.profileId}) : super(key: key);
  final String profileId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Favorite'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<FavoriteProvider>(context, listen: false)
                    .clearAllFavorite(profileId);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: FavoriteWidgetList(profileId: profileId),
    );
  }
}
