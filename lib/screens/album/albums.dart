import 'package:flutter/material.dart';
import 'package:player/constants/media_constant.dart';
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
              child: Stack(
                children: [
                  Image.asset(
                    albumCover,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius:
                                10.0,
                            spreadRadius:
                                5.0,
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${Provider.of<MediaControllerProvider>(context).albums[index].albumName}',
                                style: const TextStyle(color: Colors.white)),
                            Text(
                                '${Provider.of<MediaControllerProvider>(context).albums[index].songList?.length} songs',
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  )
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
