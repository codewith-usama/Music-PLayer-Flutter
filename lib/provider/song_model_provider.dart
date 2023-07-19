import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';


// class SongModelProvider with ChangeNotifier {
//   List<SongModel> _songs = []; // Initialize this with all your songs

//   List<SongModel> get songs => _songs;
//   List<SongModel> getFavoriteSongs() {
//     return _songs.where((song) => song.isFavorite).toList();
//   }

//   void toggleFavorite(int songId) {
//     final song = _songs.firstWhere((song) => song.id == songId);
//     song.isFavorite = !song.isFavorite;
//     notifyListeners();
//   }

//   int _id = 0;

//   int get id => _id;

//   void setId(int id) {
//     _id = id;
//     notifyListeners();
//   }
// }

class SongModelProvider with ChangeNotifier {
  List<SongModel> _songs = [];
  int _id = 0;

  List<SongModel> get songs => _songs;
  int get id => _id;

  void setSongs(List<SongModel> songs) {
    _songs = songs;
    notifyListeners();
  }

  void setId(int id) {
    _id = id;
    notifyListeners();
  }

  List<SongModel> getFavoriteSongs() {
    return _songs.where((song) => song.isFavorite).toList();
  }

  void toggleFavorite(int songId) {
    final song = _songs.firstWhere((song) => song.id == songId);
    song.isFavorite = !song.isFavorite;
    notifyListeners();
  }

  SongModel? getCurrentSong() {
    return _songs.firstWhereOrNull((song) => song.id == _id);
  }
}
