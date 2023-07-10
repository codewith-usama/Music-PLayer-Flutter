import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingSong extends StatefulWidget {
  const PlayingSong({
    Key? key,
    required this.songModel,
    required this.audioPlayer,
  }) : super(key: key);
  final SongModel songModel;
  final AudioPlayer audioPlayer;

  @override
  State<PlayingSong> createState() => _PlayingSongState();
}

class _PlayingSongState extends State<PlayingSong> {

  Duration _duration = const Duration();
  Duration _position = const Duration();

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    playSong();
  }

  playSong() {
    try {
      widget.audioPlayer.setAudioSource(AudioSource.uri(
        Uri.parse(widget.songModel.uri!),
      ));
      widget.audioPlayer.play();
      _isPlaying = true;
    } on Exception {
      log("Error parsing song");
    }

    widget.audioPlayer.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });

    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 100.0,
                      child: Icon(
                        Icons.music_note,
                        size: 80.0,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      widget.songModel.displayNameWOExt,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.songModel.artist.toString(),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          _position.toString().split('.')[0],
                        ),
                        Expanded(
                          child: Slider(
                            min: const Duration(milliseconds: 0).inSeconds.toDouble(),
                            value: _position.inSeconds.toDouble(),
                            max: _duration.inSeconds.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                changeToSeconds(value.toInt());
                                value = value;
                              });
                            },
                          ),
                        ),
                        Text(
                            _duration.toString().split('.')[0]
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 40.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_isPlaying) {
                                widget.audioPlayer.pause();
                              } else {
                                widget.audioPlayer.play();
                              }
                              _isPlaying = !_isPlaying;
                            });
                          },
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 40.0,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_next,
                            size: 40.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
}
