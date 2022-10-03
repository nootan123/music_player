import 'package:flutter/material.dart';
import 'package:player/provider/media_controller_provider.dart';
import 'package:provider/provider.dart';

class AlbumList extends StatefulWidget {
  final int index;
  const AlbumList({Key? key, required this.index}) : super(key: key);

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: Provider.of<MediaControllerProvider>(context)
              .albums[widget.index]
              .songList
              ?.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(
                  "${Provider.of<MediaControllerProvider>(context).albums[widget.index].songList?[index].path}"),
            );
          })),
    );
  }
}
