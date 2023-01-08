import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:player/screens/album/albums.dart';
import 'package:player/audio_list.dart';
import 'package:player/constants/media_constant.dart';
import 'package:player/provider/media_controller_provider.dart';
import 'package:player/service/get_audio_list.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_file_manager/flutter_file_manager.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final MiniplayerController controller = MiniplayerController();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: const Icon(
            Icons.music_note,
            size: 35,
          ),
          title: const Text("Music Player"),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('Artists'),
              ),
              Tab(
                child: Text('Albums'),
              ),
              Tab(
                child: Text('Tracks'),
              ),
              Tab(
                child: Text('Genres'),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  Stack(
                    children: [
                      Builder(builder: (context) {
                        return MyAudioList();
                      }),
                      Offstage(
                        offstage: Provider.of<MediaControllerProvider>(context)
                                .status ==
                            null,
                        child: Miniplayer(
                            controller: controller,
                            minHeight: 70,
                            maxHeight: MediaQuery.of(context).size.height,
                            builder: (height, percentage) {
                              if (Provider.of<MediaControllerProvider>(context)
                                      .status ==
                                  PlayerState.stopped) {
                                return const SizedBox.shrink();
                              } else {
                                // print(advancedPlayer.state);
                                if (percentage > 0.01) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListTile(
                                            title: Text(
                                          Provider.of<MediaControllerProvider>(
                                                  context)
                                              .songList![Provider.of<
                                                          MediaControllerProvider>(
                                                      context)
                                                  .songIndex!]
                                              .path
                                              .split('/')
                                              .last,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        )),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.60,
                                          child: Image.memory(
                                            Provider.of<MediaControllerProvider>(
                                                        context)
                                                    .audioArtwork ??
                                                placeholderCover,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  errorReplaceCover,
                                                  fit: BoxFit.cover);
                                            },
                                          ),
                                        ),
                                        StatefulBuilder(
                                            builder: (context, setState) {
                                          return Column(
                                            children: [
                                              Slider(
                                                min: 0,
                                                max: Provider.of<
                                                            MediaControllerProvider>(
                                                        context,
                                                        listen: false)
                                                    .duration!
                                                    .inSeconds
                                                    .toDouble(),
                                                value: Provider.of<
                                                            MediaControllerProvider>(
                                                        context,
                                                        listen: false)
                                                    .position!
                                                    .inSeconds
                                                    .toDouble(),
                                                onChanged: (value) {
                                                  Provider.of<MediaControllerProvider>(
                                                          context,
                                                          listen: false)
                                                      .seek(Duration(
                                                          seconds:
                                                              value.toInt()));
                                                },
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(Provider.of<
                                                                MediaControllerProvider>(
                                                            context,
                                                            listen: false)
                                                        .position!
                                                        .toString()
                                                        .substring(2, 7)),
                                                    Text(Provider.of<
                                                                MediaControllerProvider>(
                                                            context,
                                                            listen: false)
                                                        .duration!
                                                        .toString()
                                                        .substring(2, 7))
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Provider.of<MediaControllerProvider>(
                                                              context,
                                                              listen: false)
                                                          .playPrevious();
                                                    },
                                                    icon: const Icon(
                                                      Icons.skip_previous,
                                                      size: 45,
                                                    ),
                                                  ),
                                                  (Provider.of<MediaControllerProvider>(
                                                                  context)
                                                              .status ==
                                                          PlayerState.paused)
                                                      ? IconButton(
                                                          onPressed: () {
                                                            Provider.of<MediaControllerProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .play(Provider.of<
                                                                            MediaControllerProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .songIndex!);
                                                          },
                                                          icon: const Icon(
                                                            Icons.play_arrow,
                                                            size: 45,
                                                          ),
                                                        )
                                                      : IconButton(
                                                          onPressed: () {
                                                            Provider.of<MediaControllerProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .pause();
                                                          },
                                                          icon: const Icon(
                                                            Icons.pause,
                                                            size: 45,
                                                          ),
                                                        ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Provider.of<MediaControllerProvider>(
                                                              context,
                                                              listen: false)
                                                          .playNext();
                                                    },
                                                    icon: const Icon(
                                                        Icons.skip_next,
                                                        size: 45),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        })
                                      ],
                                    ),
                                  );
                                } else {
                                  return Provider.of<MediaControllerProvider>(
                                                  context)
                                              .songIndex ==
                                          null
                                      ? const SizedBox()
                                      : ListTile(
                                          title: Text(
                                            Provider.of<MediaControllerProvider>(
                                                    context)
                                                .songList![Provider.of<
                                                            MediaControllerProvider>(
                                                        context)
                                                    .songIndex!]
                                                .path
                                                .split('/')
                                                .last,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          leading: Image.memory(
                                            Provider.of<MediaControllerProvider>(
                                                        context)
                                                    .audioArtwork ??
                                                placeholderCover,
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  errorReplaceCover,
                                                  fit: BoxFit.cover);
                                            },
                                          ),
                                          trailing:
                                              (Provider.of<MediaControllerProvider>(
                                                              context)
                                                          .status ==
                                                      PlayerState.paused)
                                                  ? IconButton(
                                                      onPressed: () {
                                                        Provider.of<MediaControllerProvider>(
                                                                context,
                                                                listen: false)
                                                            .play(Provider.of<
                                                                        MediaControllerProvider>(
                                                                    context)
                                                                .songIndex!);
                                                      },
                                                      icon: const Icon(
                                                        Icons.play_arrow,
                                                        size: 45,
                                                      ),
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        Provider.of<MediaControllerProvider>(
                                                                context,
                                                                listen: false)
                                                            .pause();
                                                      },
                                                      icon: const Icon(
                                                        Icons.pause,
                                                        size: 45,
                                                      ),
                                                    ),
                                        );
                                }
                              }
                            }),
                      ),
                    ],
                  ),
                  const AlbumTab(),
                  Text('djfgk'),
                  Text('kkhiue'),
                ],
              ),
            ),
            // Text("nootan"),
          ],
        ),
      ),
    );
  }
}



// showBottomSheet(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return 
//                                 });