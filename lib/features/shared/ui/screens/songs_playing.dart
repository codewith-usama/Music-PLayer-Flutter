import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../provider/song_model_provider.dart';
import '../../widgets/music_tile.dart';
import 'now_playing.dart';

class SongsPlaying extends StatefulWidget {
  const SongsPlaying({Key? key}) : super(key: key);

  @override
  State<SongsPlaying> createState() => _SongsPlayingState();
}

class _SongsPlayingState extends State<SongsPlaying> {
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
      appBar: AppBar(
        title: const Text(
          "Music Player",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Loading"),
                ],
              ),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(child: Text("Nothing found!"));
          }
          return Stack(
            children: [
              ListView.builder(
                itemCount: item.data!.length,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                itemBuilder: (context, index) {
                  allSongs.addAll(item.data!);
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<SongModelProvider>()
                          .setId(item.data![index].id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NowPlaying(
                            songModelList: [item.data![index]],
                            audioPlayer: _audioPlayer,
                          ),
                        ),
                      );
                    },
                    child: MusicTile(
                      songModel: item.data![index],
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NowPlaying(
                          songModelList: allSongs,
                          audioPlayer: _audioPlayer,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 15, 15),
                    child: const CircleAvatar(
                      radius: 30,
                      child: Icon(
                        Icons.play_arrow,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}