import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:player/constants/media_constant.dart';
import 'package:player/home.dart';
import 'package:player/provider/media_controller_provider.dart';
import 'package:player/widgets/music_list_card.dart';
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
      appBar: AppBar(
          title: Text(Provider.of<MediaControllerProvider>(context)
                  .albums[widget.index]
                  .albumName ??
              '')),
              body: Stack(
                    children: [
                      Builder(builder: (context) {
                        return ListView.builder(
          itemCount: Provider.of<MediaControllerProvider>(context)
              .albums[widget.index]
              .songList
              ?.length,
          itemBuilder: ((context, index) {
            return MusicListCard(
              title: Provider.of<MediaControllerProvider>(context)
                      .albums[widget.index]
                      .songList?[index]
                      .path
                      .split('/')
                      .last ??
                  '',
              index: index,
              audioPath: Provider.of<MediaControllerProvider>(context)
                  .albums[widget.index]
                  .songList?[index]
                  .path,
            );
            
          }));
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
    );
  }
}
