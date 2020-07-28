import 'package:flutter/material.dart';
import 'package:music_player/config/colors.dart';
import 'package:music_player/widgets/customButton.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  double _currentVolume = 1;

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Toosie Slide",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text(
                  "Drake",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
                Slider.adaptive(
                    activeColor: BLACK_THEME,
                    inactiveColor: BLACK_THEME.withOpacity(0.3),
                    value: .1,
                    onChanged: (val) {}),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text("2:04"), Text("-2.04")],
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
                      ),
                      CustomButton(
                        Icon(
                          Icons.play_arrow,
                          size: 28,
                        ),
                        offset: Offset(1, 2),
                        width: 60,
                        height: 60,
                      ),
                      CustomButton(
                        Icon(
                          Icons.skip_next,
                          size: 28,
                        ),
                        offset: Offset(1, 2),
                        width: 40,
                        height: 40,
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
