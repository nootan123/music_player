import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:audiotagger/audiotagger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_ffmpeg/media_information.dart';
import 'package:player/constants/media_constant.dart';
import 'package:player/models/album_model.dart';

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
  List<AlbumModel> _albums = [];
  /////get
  PlayerState? get status => _status;
  Duration? get duration => _duration;
  Duration? get position => _position;
  int? get songIndex => _songIndex;
  List<FileSystemEntity>? get songList => _songList;
  FileSystemEntity? get audioFile => _audioFile;
  MediaInformation? get metadata => _metadata;
  Uint8List? get audioArtwork => _artwork;
  List<AlbumModel> get albums => _albums;

  MediaControllerProvider() {
    _audioPlayer = AudioPlayer();
    FlutterFFprobe flutterFFprobe = FlutterFFprobe();
    _duration = Duration.zero;
    _audioPlayer?.onPlayerStateChanged.listen((state) {
      _status = state;
    });
    _audioPlayer?.onPositionChanged.listen((newPosition) {
      _position = newPosition;
      notifyListeners();
    });
    _audioPlayer?.onPlayerComplete.listen((event) {
      play(songIndex! + 1);
    });
    getMediaList();
    getAlbumList();
  }
  getMediaList() async {
    Directory dir = Directory('/storage/emulated/0/');
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

  play(int index, {String? audioPath}) async {
    audioPath != null
        ? _audioPlayer?.play(DeviceFileSource(audioPath))
        : await _audioPlayer?.play(DeviceFileSource(_songList[index].path));
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

  getAlbumList() async {
    for (int i = 0; i < _songList.length; i++) {
      final audioTrack =
          await Audiotagger().readTagsAsMap(path: _songList[i].path);
      final albumName = audioTrack?['album'] ?? unknownAlbum;
      int index = _albums.indexWhere((album) => album.albumName == albumName);
      if (index == -1) {
        final albumModel =
            AlbumModel(albumName: albumName, songList: [_songList[i]]);
        _albums.add(albumModel);
      } else {
        _albums[index].songList?.add(_songList[i]);
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }
}
