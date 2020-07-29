import 'package:flutter/material.dart';
import 'package:music_player/screens/nowPlaying.dart';

import 'config/colors.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: currentTheme()
,      home: Home(),
    );
  }
}
