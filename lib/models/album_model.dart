import 'dart:convert';
import 'dart:io';

AlbumModel albumModelFromJson(String str) =>
    AlbumModel.fromJson(json.decode(str));

String albumModelToJson(AlbumModel data) => json.encode(data.toJson());

class AlbumModel {
  AlbumModel({
    this.albumName,
    this.albumCover,
    this.songList,
  });

  String? albumName;
  String? albumCover;
  List<FileSystemEntity>? songList;

  factory AlbumModel.fromJson(Map<String, dynamic> json) => AlbumModel(
        albumName: json["albumName"],
        albumCover: json["albumCover"],
        songList: List<FileSystemEntity>.from(json["songList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "albumName": albumName,
        "albumCover": albumCover,
        "songList": List<dynamic>.from(songList!.map((x) => x)),
      };
}
