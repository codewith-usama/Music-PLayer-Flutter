import 'package:flutter/material.dart';
import 'package:music_player/widgets/music_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../provider/song_model_provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    final List<SongModel> favoriteSongs =
        context.watch<SongModelProvider>().getFavoriteSongs();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: 70.0),
        decoration: const BoxDecoration(
          color: Color(0xFFD07B65),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(150.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        child: ListView.builder(
          itemCount: favoriteSongs.length,
          itemBuilder: (context, index) {
            final song = favoriteSongs[index];
            return MusicTile(
              songModel: song,
            );
          },
        ),
      ),
    );
  }
}
