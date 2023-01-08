import 'dart:io';
import 'package:flutter/material.dart';
import 'package:player/provider/media_controller_provider.dart';
import 'package:player/widgets/music_list_card.dart';
import 'package:provider/provider.dart';

class MyAudioList extends StatelessWidget {
  MyAudioList({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Provider.of<MediaControllerProvider>(context).songList?.length,
      itemBuilder: (context, index) {
        return MusicListCard(
            title: Provider.of<MediaControllerProvider>(context)
                .songList![index]
                .path
                .split('/')
                .last,
            index: index);
      },
    );
  }
}
