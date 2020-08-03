import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_music_player/models/music.dart';

class FetchSongs {
  static List<SongInfo> allSongs;
  FlutterAudioQuery _audioQuery;
  FetchSongs() {
    _audioQuery = FlutterAudioQuery();
  }
  Future<List<SongInfo>> getSongs() async {
    allSongs =
        await _audioQuery.getSongs();
    return allSongs;
  }
}
