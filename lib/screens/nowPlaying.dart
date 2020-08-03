import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/providers/currentSongProvider.dart';
import 'package:flutter_music_player/services/fetchSongs.dart';
import 'package:music_player/music_player.dart';
import 'package:provider/provider.dart';
import '../config/colors.dart';
import '../widgets/customButton.dart';

class NowPlaying extends StatefulWidget {
  final List<SongInfo> songs;
  int index;

  NowPlaying({this.songs, this.index});
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  double _currentVolume = 1;

  MusicPlayer musicPlayer;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // print(CurrentSongProvider().currentIndex);
    playSong();

    musicPlayer.onIsPaused = () {
      setState(() {
        isPlaying = false;
      });
    };

    musicPlayer.onIsPlaying = () {
      setState(() {
        isPlaying = true;
      });
    };

    musicPlayer.onPosition = (double pos) {
      // print(pos);
      // print( double.parse(widget.songs[widget.index].duration)*10);
      setState(() {
        currentPoint = pos;
      });
    };
  }

  void _onNext() {
    print(FetchSongs.allSongs);
    musicPlayer.play(MusicItem(
        url: FetchSongs.allSongs[widget.index + 1].filePath,
        trackName: FetchSongs.allSongs[widget.index + 1].title,
        artistName: FetchSongs.allSongs[widget.index + 1].artist,
        albumName: FetchSongs.allSongs[widget.index + 1].album,
        coverUrl: FetchSongs.allSongs[widget.index + 1].albumArtwork,
        duration: Duration(
            milliseconds:
                int.parse(FetchSongs.allSongs[widget.index + 1].duration))));
    widget.index += 1;
  }

  void _onPrev() {
    musicPlayer.play(MusicItem(
        url: FetchSongs.allSongs[widget.index - 1].filePath,
        trackName: FetchSongs.allSongs[widget.index - 1].title,
        artistName: FetchSongs.allSongs[widget.index - 1].artist,
        albumName: FetchSongs.allSongs[widget.index - 1].album,
        coverUrl: FetchSongs.allSongs[widget.index - 1].albumArtwork,
        duration: Duration(
            milliseconds:
                int.parse(FetchSongs.allSongs[widget.index - 1].duration))));
    widget.index = -1;
  }

  void playSong() async => await musicPlayer.play(MusicItem(
        trackName: widget.songs[widget.index].title,
        albumName: widget.songs[widget.index].album,
        artistName: widget.songs[widget.index].artist,
        url: widget.songs[widget.index].filePath,
        coverUrl: widget.songs[widget.index].albumArtwork == null
            ? "assets/images/music-icon.png"
            : widget.songs[widget.index].albumArtwork,
        duration: Duration(
            milliseconds: int.parse(widget.songs[widget.index].duration)),
      ));

  Future<void> initPlatformState() {
    musicPlayer = MusicPlayer();
  }

  bool isPlaying = true;

  void _onPlayTapped() {
    if (isPlaying) {
      isPlaying = false;
      musicPlayer.pause();
      setState(() {});
      return;
    }
    isPlaying = true;
    musicPlayer.resume();
    setState(() {});
  }

  double currentPoint = 0;
  @override
  Widget build(BuildContext context) {
    // final CurrentSongProvider currentSongProvider =
    //     Provider.of<CurrentSongProvider>(context);
    final Size DEVSIZE = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: AppBar(
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                  offset: Offset(1, 2),
                  width: 40,
                  onClick: () => Navigator.pop(context),
                ),
              ),
              title: Text(
                "Now Playing",
              ),
              centerTitle: true,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                      Icon(
                        Icons.more_horiz,
                        size: 30,
                      ),
                      offset: Offset(1, 2),
                      width: 40.0),
                )
              ],
            ),
          ),
        ),
        body: Container(
          height: DEVSIZE.height,
          width: DEVSIZE.width,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  child: Container(
                    height: DEVSIZE.height * (0.30),
                    width: DEVSIZE.width * (0.6),
                    child: widget.songs[widget.index].albumArtwork == null
                        ? Image.asset("assets/images/music-icon.png")
                        : Image.file(
                            File(widget.songs[widget.index].albumArtwork),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    widget.songs[widget.index].title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text(
                  widget.songs[widget.index].artist,
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
                Slider(
                    activeColor: BLACK_THEME,
                    inactiveColor: BLACK_THEME.withOpacity(0.3),
                    min: 0.0,
                    max: 1.0,
                    value: currentPoint,
                    onChanged: (val) {
                      setState(() {
                        musicPlayer.seek(val);
                        currentPoint = val;
                      });
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("0:00"),
                      Text(
                          "${((double.parse(widget.songs[widget.index].duration)) / 60000).toStringAsFixed(2).replaceFirst(".", ":")}")
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomButton(
                        Icon(
                          Icons.skip_previous,
                          size: 28,
                        ),
                        offset: Offset(1, 2),
                        width: 40,
                        height: 40,
                        onClick: _onPrev,
                      ),
                      CustomButton(
                          Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 28,
                          ),
                          offset: Offset(1, 2),
                          width: 60,
                          height: 60,
                          onClick: _onPlayTapped),
                      CustomButton(
                        Icon(
                          Icons.skip_next,
                          size: 28,
                        ),
                        offset: Offset(1, 2),
                        width: 40,
                        height: 40,
                        onClick: _onNext,
                      )
                    ],
                  ),
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.volume_down),
                              Expanded(
                                child: Slider(
                                    activeColor: BLACK_THEME,
                                    inactiveColor: BLACK_THEME.withOpacity(0.3),
                                    value: _currentVolume,
                                    onChanged: (val) {
                                      setState(() {
                                        _currentVolume = val;
                                      });
                                    }),
                              ),
                              Icon(Icons.volume_up),
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
