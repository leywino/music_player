import 'package:firstproject/database/favorite_model.dart';
import 'package:firstproject/database/most_played_model.dart';
import 'package:firstproject/database/recently_played_model.dart';
import 'package:firstproject/widgets/HomeScreen/list.dart';
import 'package:flutter/material.dart';

checkRecentlyPlayed(Recently value, index) {
  List<Recently> list = recentlybox.values.toList();
  bool isAlreadyAdded =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isAlreadyAdded == true) {
    recentlybox.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    recentlybox.deleteAt(index);
    recentlybox.add(value);
  }
}

checkMostPlayed(Most value, index) {
  List<Most> list = mostbox.values.toList();
  bool isAlreadyAdded =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isAlreadyAdded == true) {
    mostbox.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    mostbox.deleteAt(index);
    mostbox.put(index, value);
  }
  int count = value.count ?? 0;
  value.count = count + 1;
}

addToFavorites(int index, Favorite value, BuildContext context) async {
  List<Favorite> favdb = favoritebox.values.toList();
  bool isAlreadyThere =
      favdb.where((element) => element.songname == value.songname).isEmpty;
  if (isAlreadyThere == true) {
    favoritebox.add(value);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Text("Added to favorites"),
    ));
  } else {
    int index =
        favdb.indexWhere((element) => element.songname == value.songname);
    favoritebox.deleteAt(index);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Text("Removed from favorites"),
    ));
  }
}

bool checkFavoriteStatus(int index, BuildContext context) {
  final songdb = songbox.values.toList();
  Favorite value = Favorite(
      songname: songdb[index].songname,
      artist: songdb[index].artist,
      duration: songdb[index].duration,
      songurl: songdb[index].songurl,
      id: songdb[index].id);
  List<Favorite> favdb = favoritebox.values.toList();
  bool isAlreadyThere =
      favdb.where((element) => element.songname == value.songname).isEmpty;
  return isAlreadyThere ? false : true;
}