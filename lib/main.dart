import 'package:flutter/material.dart';
import 'package:flutter_music_player/providers/currentSongProvider.dart';
import 'package:provider/provider.dart';

import 'config/colors.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentSongProvider())
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music Player',
        theme: currentTheme(),
        home: Home(),
      ),
    );
  }
}
