import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:firstproject/screens/now_playing.dart';
import 'package:firstproject/utilities/texts.dart';
import 'package:firstproject/widgets/RecentlyPlayed/title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyLists extends StatefulWidget {
  const RecentlyLists({super.key});

  @override
  State<RecentlyLists> createState() => _RecentlyListsState();
}

final recentlybox = RecentlyBox.getInstance();
final player = AssetsAudioPlayer.withId('key');
List<Recently> recentlysongslist = [];
List<Audio> allsongs = [];

class _RecentlyListsState extends State<RecentlyLists> {
  @override
  void initState() {
    List<Recently> recentlydb = recentlybox.values.toList();
    // for (var items in recentlysongslist) {
    //   allsongs.add(Audio.file(items.songurl!,
    //       metas: Metas(
    //           title: items.songname,
    //           artist: items.artist,
    //           id: items.id.toString())));
    // }
    print('kajkfhjajfhsDJFIL;SDHAFGIJASDF;JASIKF');
    for (var item in recentlydb) {
      allsongs.add(
        Audio.file(
          item.songurl.toString(),
          metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString(),
          ),
        ),
      );
    }
    setState(() {});
    super.initState();
  }

  List<Recently> recentlydb = [];

  @override
  Widget build(BuildContext context) {
      void initState() {
      

      List<Recently> Recentplay = recentlybox.values.toList();

      super.initState();
}
    double vww = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<Box<Recently>>(
      valueListenable: recentlybox.listenable(),
      builder: (context, Box<Recently> allrecsongs, child) {
        List<Recently> recdb = allrecsongs.values.toList();
        return recdb.isEmpty
            ? Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: vww * 0.05),
                    child: const Text(
                      'You have no recently played songs!',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              )
            : ValueListenableBuilder<Box<Recently>>(
                valueListenable: recentlybox.listenable(),
                builder: (context, Box<Recently> allrecsongs, child) {
                  List<Recently> rooydb = allrecsongs.values.toList();
                  return ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: rooydb.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          // HomeBottomTile.vindex.value = index;
                          // NowPlayingScreen.spindex.value = index;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => NowPlayingScreen(
                                intindex: index,
                                opendb: rooydb,
                              ),
                            ),
                          );
                          player.open(
                              Playlist(audios: allsongs, startIndex: index),
                              showNotification: notificationBool,
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                              loopMode: LoopMode.playlist);
                          // player.play();
                          // await player.open(
                          //   Audio.file(recdb[index].songurl!),
                          //   showNotification: true,
                          //   playInBackground: PlayInBackground.disabledPause,
                          //   audioFocusStrategy: const AudioFocusStrategy.request(
                          //     resumeAfterInterruption: true,
                          //     resumeOthersPlayersAfterDone: true,
                          //   ),
                          // );
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: QueryArtworkWidget(
                            artworkBorder: BorderRadius.circular(8),
                            keepOldArtwork: true,
                            id: rooydb[index].id!,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                'assets/images/music.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          rooydb[index].songname!,
                          style: GoogleFonts.rubik(
                              fontSize: 20, color: Colors.white),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(bottom: vww * 0.035),
                          child: Text(
                            rooydb[index].artist!,
                            style: GoogleFonts.rubik(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ),
                      );
                    },
                  );
                });
      },
    );
  }
}

// bool checkIndexSkip(int intindex, List<Recently> recdb) {
//   return (intindex > allsongs.length - 1) ? false : true;
// }

// bool checkIndexPrev(int intindex, List<Recently> recdb) {
//   return (intindex <= 0) ? true : false;
// }
