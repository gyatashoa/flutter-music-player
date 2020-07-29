import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/config/colors.dart';
import 'package:music_player/main.dart';
import 'package:music_player/models/music.dart';
import 'package:music_player/screens/nowPlaying.dart';

class SongsTab extends StatelessWidget {
  void _playSong(BuildContext context) {
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => NowPlaying()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 40,
              itemBuilder: (context, index) => Column(
                    children: <Widget>[
                      ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 40,
                            child: Image.asset(
                              "assets/images/1997.jpeg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text("Song title"),
                        subtitle: Text("Yaa pono"),
                        trailing: Text("2:34"),
                        onTap: () => _playSong(context),
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
