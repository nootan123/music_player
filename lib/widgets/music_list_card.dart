import 'package:flutter/material.dart';
import 'package:player/provider/media_controller_provider.dart';
import 'package:provider/provider.dart';

class MusicListCard extends StatelessWidget {
  final String title;
 final int index;
  const MusicListCard({Key? key,required this.title, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(title),
      leading:const Icon(Icons.audiotrack),
      trailing:const Icon(
        Icons.play_arrow,
        color: Colors.redAccent,
      ),
      onTap: () async {
        await Provider.of<MediaControllerProvider>(context, listen: false)
            .play(index);
      },
    ));
  }
}
