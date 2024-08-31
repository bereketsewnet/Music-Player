import 'package:audioplayers/audioplayers.dart';
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
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if(newIndex != null) {
      play(); // play the song at the new index
    }
    notifyListeners();
  }
//////////////////////////////////////////////////////////////////////////////

  bool _isPlaying = false;

  // play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path));// play the new song
    _isPlaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if(_currentSongIndex != null) {
      if(_currentSongIndex! < _playlist.length - 1){
        // go to the next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if it's the last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviousSong() async {
    // if more the 2 second have passed, restart the current song

    if(_currentDuration.inSeconds > 2) {

    }else {
      // if it's within first 2 second of the song, go to previous song
      if(_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      }else {
        // if it's the first song, loop back to last song
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause and play
  void pauseOrPlay() async {
    if(_isPlaying) {
      pause();
    }else {
      play();
    }
  }

  // audio player
  AudioPlayer _audioPlayer = AudioPlayer();

  // constructor

  playlistProver() {
    listenToDuration();
  }

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  // list of duration
  void listenToDuration() {
    // listen of total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
    // listen for song completed
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }
}
