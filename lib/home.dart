import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:miniplayer/miniplayer.dart';
// import 'package:flutter_file_manager/flutter_file_manager.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? duration;
  bool? playing;
  AudioPlayer? advancedPlayer;
  Future loadMusic() async {
    // advancedPlayer.stop();

    advancedPlayer = await AudioCache().loop("../lib/assets/piya.mp3");

    duration = await advancedPlayer!.getDuration();

    print("Duration is: $duration");
  }

  Future pauseMusic() async {
    await advancedPlayer!.pause();
  }

  Future stopMusic() async {
    await advancedPlayer!.stop();
  }

  Future resumeMusic() async {
    await advancedPlayer!.resume();
  }

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
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.replay),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
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
                // controller: ,
                children: [
                  Stack(
                    children: [
                      Builder(builder: (context) {
                        print(advancedPlayer);
                        return GestureDetector(
                          child: ListTile(
                            title: const Text("Song Name"),
                            subtitle: const Text("Artist Name"),
                            leading: Container(
                              child: Image.asset('lib/assets/cover.jfif'),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_vert),
                            ),
                          ),
                          onTap: () async {
                            // playLocal();
                            await loadMusic();
                            setState(() {
                              playing = true;
                            });
                            print('ssss');
                          },
                        );
                      }),
                      Offstage(
                        offstage: playing == null,
                        child: Miniplayer(
                            controller: controller,
                            minHeight: 70,
                            maxHeight: MediaQuery.of(context).size.height,
                            builder: (height, percentage) {
                              if (advancedPlayer == null)
                                return const SizedBox.shrink();
                              else {
                                // print(advancedPlayer.state);
                                if (percentage > 0.01) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: const Text("Song Name"),
                                          subtitle: const Text("Artist Name"),
                                          leading: Container(
                                            child: Image.asset(
                                                'lib/assets/cover.jfif'),
                                          ),
                                          trailing: SizedBox(
                                            width: 50,
                                            child: Row(
                                              children: [
                                                Icon(Icons.search),
                                                Icon(Icons.featured_play_list)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.66,
                                          child: Image.asset(
                                            'lib/assets/cover.jfif',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            ProgressBar(
                                              progress: Duration(seconds: 2000),
                                              total:
                                                  Duration(seconds: duration!),
                                            ),
                                            // LinearProgressIndicator(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.skip_previous,
                                                    size: 45,
                                                  ),
                                                ),
                                                (playing == false)
                                                    ? IconButton(
                                                        onPressed: () {
                                                          print(playing);
                                                          resumeMusic();

                                                          setState(() {
                                                            playing = true;
                                                          });
                                                        },
                                                        icon: const Icon(
                                                          Icons.play_arrow,
                                                          size: 45,
                                                        ),
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          print(playing);

                                                          pauseMusic();
                                                          setState(() {
                                                            playing = false;
                                                          });
                                                        },
                                                        icon: const Icon(
                                                          Icons.pause,
                                                          size: 45,
                                                        ),
                                                      ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.skip_next,
                                                      size: 45),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return ListTile(
                                    title: const Text("Song Name"),
                                    subtitle: const Text("Artist Name"),
                                    leading: Container(
                                      child:
                                          Image.asset('lib/assets/cover.jfif'),
                                    ),
                                    trailing: (playing == false)
                                        ? IconButton(
                                            onPressed: () {
                                              print(playing);
                                              resumeMusic();

                                              setState(() {
                                                playing = true;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.play_arrow,
                                              size: 45,
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              print(playing);

                                              pauseMusic();
                                              setState(() {
                                                playing = false;
                                              });
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
                  Text('asdf'),
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