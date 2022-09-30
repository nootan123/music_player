import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:audiotagger/audiotagger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_ffmpeg/media_information.dart';

class MediaControllerProvider with ChangeNotifier {
  AudioPlayer? _audioPlayer;
  PlayerState? _status;
  Duration? _duration;
  Duration? _position;
  int? _songIndex;
  List<FileSystemEntity> _songList = [];
  FileSystemEntity? _audioFile;
  MediaInformation? _metadata;
  FlutterFFprobe? flutterFFprobe;
  Uint8List? _artwork;
  /////get
  PlayerState? get status => _status;
  Duration? get duration => _duration;
  Duration? get position => _position;
  int? get songIndex => _songIndex;
  List<FileSystemEntity>? get songList => _songList;
  FileSystemEntity? get audioFile => _audioFile;
  MediaInformation? get metadata => _metadata;
  Uint8List? get audioArtwork => _artwork;

  MediaControllerProvider() {
    _audioPlayer = AudioPlayer();
    FlutterFFprobe flutterFFprobe = FlutterFFprobe();
    _duration = Duration.zero;
    _audioPlayer?.onPlayerStateChanged.listen((state) {
      _status = state;
    });
    // _audioPlayer?.onDurationChanged.listen((duration) {
    //   _duration = duration;
    //   notifyListeners();
    // });
    _audioPlayer?.onPositionChanged.listen((newPosition) {
      _position = newPosition;
      notifyListeners();
    });
    getMediaList();
  }
  getMediaList() async {
    Directory dir = Directory('/storage/emulated/0/Music/');
    String mp3Path = dir.toString();

    var _files;
    _files = dir.listSync(recursive: true, followLinks: false);
    for (FileSystemEntity entity in _files) {
      String path = entity.path;
      if (path.endsWith('.mp3')) {
        _songList.add(entity);
      }
    }
    notifyListeners();
  }

  play(int index) async {
    await _audioPlayer?.play(DeviceFileSource(_songList[index].path));
    Future.delayed(const Duration(seconds: 2), () async {
      _duration = await _audioPlayer?.getDuration();
    });
    _songIndex = index;

    await getAudioTags(_songList[index].path);
    notifyListeners();
  }

  seek(Duration position) async {
    _audioPlayer?.seek(position);
  }

  playNext() async {
    play(songIndex! + 1);
  }

  playPrevious() async {
    play(songIndex! - 1);
  }

  pause() async {
    await _audioPlayer?.pause();
    notifyListeners();
  }

  stop() async {
    await _audioPlayer?.stop();
    notifyListeners();
  }

  getAudioTags(String url) async {
    print("URL: $url");
    final audioTags = await Audiotagger().readTagsAsMap(path: url);
    final audioArtwork = await Audiotagger().readArtwork(path: url);
    _artwork = audioArtwork;
    print(audioArtwork);
    print("MetaData: $audioTags");
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }
}
