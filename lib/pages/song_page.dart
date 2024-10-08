import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
      builder: (context, value, child) {
        // get play list
        final List<Song> playlist = value.playList;

        final Song currentSong = playlist[value.currentSongIndex ?? 0];
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 25,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      const Text('P L A Y L I S Y'),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu,
                        ),
                      ),
                    ],
                  ),
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(currentSong.albumArtImagePath),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(currentSong.artistName),
                                ],
                              ),
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatedTime(value.currentDuration),
                            ),
                            const Icon(Icons.shuffle),
                            const Icon(Icons.repeat),
                            Text(
                              formatedTime(value.totalDuration),
                            ),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          min: 0,
                          max: 100,
                          value: 78,
                          activeColor: Colors.green,
                          onChanged: (double double) {
                            // dring when the user slide around
                          },
                          onChangeEnd: (double double) {
                            // sliding has finished, go to that postiton in song duration
                            value.seek(
                              Duration(
                                seconds: double.toInt(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      // skip previous
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            value.playPreviousSong();
                          },
                          child: const NeuBox(
                            child: Icon(
                              Icons.skip_previous,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            value.pauseOrPlay();
                          },
                          child: NeuBox(
                            child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            value.playNextSong();
                          },
                          child: const NeuBox(
                            child: Icon(
                              Icons.skip_next,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String formatedTime(Duration duration) {
    String twoDigitSecond =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSecond";

    return formattedTime;
  }
}
