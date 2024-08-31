import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlayListProvider extends ChangeNotifier {
  // current song playing index
  int? _currentSongIndex;

  // song list
  final List<Song> _playlist = [
    const Song(
      songName: 'AYZOH',
      artistName: 'Abdu Kiyar',
      albumArtImagePath: 'assets/image/abdu.jpeg',
      audioPath: 'audio/abdu.mp3',
    ),
    const Song(
      songName: "Don't let me down",
      artistName: 'Ana',
      albumArtImagePath: 'assets/image/ana.jpeg',
      audioPath: 'audio/ana.mp3',
    ),
    const Song(
      songName: 'No Whala',
      artistName: 'Ayovi',
      albumArtImagePath: 'assets/image/ayovi.jpeg',
      audioPath: 'audio/ayovi.mp3',
    ),
    const Song(
      songName: 'Baby',
      artistName: 'Cris Brown',
      albumArtImagePath: 'assets/image/cris.jpeg',
      audioPath: 'audio/cris.mp3',
    ),
    const Song(
      songName: 'Stay',
      artistName: 'Justin',
      albumArtImagePath: 'assets/image/justin.jpg',
      audioPath: 'audio/justin.mp3',
    ),
  ];

  List<Song> get playList => _playlist;

  int? get currentSongIndex => _currentSongIndex;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    notifyListeners();
  }
}
