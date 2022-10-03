import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:player/provider/media_controller_provider.dart';
import 'package:player/screens/album/album_list.dart';
import 'package:provider/provider.dart';

class AlbumTab extends StatefulWidget {
  const AlbumTab({Key? key}) : super(key: key);

  @override
  State<AlbumTab> createState() => _AlbumTabState();
}

class _AlbumTabState extends State<AlbumTab> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() =>
        Provider.of<MediaControllerProvider>(context, listen: false)
            .getAlbumList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: Provider.of<MediaControllerProvider>(context).albums.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Card(
              color: Colors.amber,
              child: Column(
                children: [
                  Text(
                      '${Provider.of<MediaControllerProvider>(context).albums[index].albumName}'),
                  Text(
                      '${Provider.of<MediaControllerProvider>(context).albums[index].songList?.length} songs'),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AlbumList(index: index)));
            },
          );
        });
  }
}
