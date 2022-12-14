import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firstproject/database/most_played_model.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostLists extends StatefulWidget {
  const MostLists({super.key});

  @override
  State<MostLists> createState() => _MostListsState();
}

final recentlybox = RecentlyBox.getInstance();
final mostbox = MostBox.getInstance();
final player = AssetsAudioPlayer.withId('key');
List<Recently> recentlysongslist = [];
List<Audio> songdb = [];
List<Most> mostsongslist = [];

class _MostListsState extends State<MostLists> {
  @override
  void initState() {
    // mostsongslist.clear();
    for (var items in mostsongslist) {
      songdb.add(Audio.file(items.songurl,
          metas: Metas(
              title: items.songname,
              artist: items.artist,
              id: items.id.toString())));
    }
    List<Most> songlist = mostbox.values.toList();
    int i = 0;
    for (var item in songlist) {
      if (item.count > 5 &&
          mostsongslist
              .where((element) => element.songname == item.songname)
              .isEmpty) {
        mostsongslist.insert(i, item);
        i++;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double vww = MediaQuery.of(context).size.width;
    return mostsongslist.isEmpty
        ? Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: vww * 0.05),
                child: const Text(
                  'You have no most played songs!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mostsongslist.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: null,
                // onTap: () async {
                //   // HomeBottomTile.vindex.value = index;
                //   // NowPlayingScreen.spindex.value = index;
                //   // Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute(
                //   //     builder: (ctx) => NowPlayingScreen(
                //   //       intindex: index,
                //   //       opendb: mostdb,
                //   //     ),
                //   //   ),
                //   // );

                //   // await player.open(
                //   //   Audio.file(mostsongslist[index].songurl),
                //   //   showNotification: notificationBool,
                //   //   playInBackground: PlayInBackground.disabledPause,
                //   //   audioFocusStrategy: const AudioFocusStrategy.request(
                //   //     resumeAfterInterruption: true,
                //   //     resumeOthersPlayersAfterDone: true,
                //   //   ),
                //   // );
                // },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: QueryArtworkWidget(
                    artworkBorder: BorderRadius.circular(8),
                    keepOldArtwork: true,
                    id: mostsongslist[index].id,
                    type: ArtworkType.AUDIO,
                  ),
                ),
                title: Text(
                  mostsongslist[index].songname,
                  style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(bottom: vww * 0.035),
                  child: Text(
                    mostsongslist[index].artist,
                    style: GoogleFonts.rubik(color: Colors.grey, fontSize: 18),
                  ),
                ),
              );
            },
          );
  }
}

bool checkIndexSkip(int intindex, List<Most> mostdb) {
  return (intindex < mostdb.length - 1) ? false : true;
}

bool checkIndexPrev(int intindex, List<Most> mostdb) {
  return (intindex <= 0) ? true : false;
}
