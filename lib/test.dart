import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/provider/song_model_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'features/shared/ui/screens/now_playing.dart';
import 'features/shared/widgets/music_tile.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<SongModel> allSongs = [];
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    PermissionStatus status = await Permission.audio.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: 70.0),
        decoration: const BoxDecoration(
          color: Color(0xFF4B4B7B),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(150.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(left: 10.0),
                    margin: const EdgeInsets.only(
                      top: 30.0,
                      left: 20.0,
                    ),
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD07B65),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Icon(Icons.favorite),
                        Text(
                          'Favourite',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(left: 10.0),
                    margin: const EdgeInsets.only(
                      top: 30.0,
                      left: 20.0,
                    ),
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6968B7),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Icon(Icons.playlist_add_check_circle_outlined),
                        Text(
                          'Favourite',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(left: 10.0),
                    margin: const EdgeInsets.only(
                      top: 30.0,
                      left: 20.0,
                    ),
                    width: 100.0,
                    height: 100.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFDEDF7A),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60.0),
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Icon(Icons.watch_later_outlined),
                        Text(
                          'Recent',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              alignment: Alignment.topLeft,
              child: const Text(
                'All songs',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            FutureBuilder<List<SongModel>>(
              future: _audioQuery.querySongs(
                sortType: null,
                orderType: OrderType.ASC_OR_SMALLER,
                uriType: UriType.EXTERNAL,
                ignoreCase: true,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const Center(
                    child: Text("Error loading songs"),
                  );
                }

                // Save the list of songs to the SongModelProvider
                context.read<SongModelProvider>().setSongs(snapshot.data!);

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final song = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        context.read<SongModelProvider>().setId(song.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NowPlaying(
                              songModelList: snapshot.data!,
                              audioPlayer: _audioPlayer,
                            ),
                          ),
                        );
                      },
                      child: MusicTile(
                        songModel: song,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
