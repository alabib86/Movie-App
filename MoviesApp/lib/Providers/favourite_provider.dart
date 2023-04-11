import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/movie_model.dart';

class FavouriteProvider with ChangeNotifier {
  List<MovieModel> favouriteList = [];

  FavouriteProvider() {
    restorePreference();
  }

  restorePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? favString = prefs.getString("fav");
    favouriteList=MovieModel.decode(favString!);
  }

  savePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodeData = MovieModel.encode(favouriteList);
    await prefs.setString("fav", encodeData);
  }

  addToFav(id, title, posterPath) {
    MovieModel m = MovieModel();
    m.id = id;
    m.title = title;
    m.posterPath = posterPath;
    m.favourite = true;
    favouriteList.add(m);
    savePreference();
    notifyListeners();
  }

  deleteFromFavById(id) {
    favouriteList.removeWhere((element) => element.id == id);
    savePreference();
    notifyListeners();
  }
}
