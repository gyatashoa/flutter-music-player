import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/tabs/albums.dart';
import 'package:music_player/tabs/playlist.dart';
import 'package:music_player/tabs/songs.dart';
import 'package:music_player/widgets/customButton.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  MusicFinder audioPlayer;

  TabController _mainTabController;

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 3, vsync: this);
    audioPlayer = new MusicFinder();
    _getSongs();
  }

  void _getSongs() async {
    var songs = await MusicFinder.allSongs();
    List allSongs = List.from(songs);
    print(allSongs);
  }

  List<Widget> _getBottomTabs() => [
        Tab(child: Text("Songs")),
        Tab(child: Text("Albums")),
        Tab(child: Text("Playlists")),
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Music Player"),
          centerTitle: true,
          bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              controller: _mainTabController,
              tabs: _getBottomTabs()),
          elevation: 2,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                Icon(Icons.settings),
                offset: Offset(1, 2),
                width: 40,
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Divider(
              height: 0,
            ),
            Expanded(
                child: Container(
              child: TabBarView(
                  controller: _mainTabController,
                  children: <Widget>[SongsTab(), Albums(), PlayList()]),
            ))
          ],
        ),
      ),
    );
  }
}
