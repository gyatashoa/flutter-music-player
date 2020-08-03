import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/providers/currentSongProvider.dart';
import 'package:music_player/music_player.dart';

import '../screens/nowPlaying.dart';

class SongsTab extends StatelessWidget {
  final List<SongInfo> songs;
  SongsTab({@required this.songs});

  

  void _playSong(BuildContext context, int index) {
    CurrentSongProvider.currentIndex = index;
    print(CurrentSongProvider .currentIndex);
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => NowPlaying(
                  songs: songs,
                  index:index
                  // next: onPlayNext,
                  // prev: onPlayPrev,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: songs.length,
              itemBuilder: (context, index) => Column(
                    children: <Widget>[
                      ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 40,
                            height: 40,
                            child: songs[index].albumArtwork == null
                                ? Image.asset("assets/images/music-icon.png")
                                : Image.file(
                                    File(songs[index].albumArtwork),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        title: Text("${songs[index].title}"),
                        subtitle: Text("${songs[index].artist}"),
                        trailing: Text(
                            "${((double.parse(songs[index].duration)) / 60000).toStringAsFixed(2).replaceFirst(".", ":")}"),
                        onTap: () => _playSong(context, index),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Divider(
                          height: 0,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )),
        ],
      ),
    );
  }
}
