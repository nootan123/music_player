import 'dart:io';
import 'package:flutter/material.dart';
import 'package:player/provider/media_controller_provider.dart';
import 'package:provider/provider.dart';

class MyAudioList extends StatelessWidget {
  MyAudioList({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //if file/folder list is grabbed, then show here
      itemCount: Provider.of<MediaControllerProvider>(context).songList?.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
          title: Text(Provider.of<MediaControllerProvider>(context)
              .songList![index]
              .path
              .split('/')
              .last),
          leading: Icon(Icons.audiotrack),
          trailing: Icon(
            Icons.play_arrow,
            color: Colors.redAccent,
          ),
          onTap: () async {
            await Provider.of<MediaControllerProvider>(context, listen: false)
                .play(index);
          },
        ));
      },
    );
  }
}
