import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/movie_model.dart';

const String _key = "cc5b812a11ac76a779e943b41a16756e";

class LatestMoviesProvider with ChangeNotifier {
  bool isLoadingLatest = false;
  final String _latest = "https://api.themoviedb.org/3/movie/popular?api_key=";

//latest movie rerurn only one object so replaced with popular

  List<MovieModel> latestMoviesList = [];
  List<MovieModel> showList = [];

  LatestMoviesProvider() {
    getLatestData();
  }

  getLatestData() async {
    String target = "$_latest$_key";
    var url = Uri.parse(target);

    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);


    if (response.statusCode == 200) {
      for (var i in responseBody['results']) {
        latestMoviesList.add(MovieModel.fromMap(i));
      }
      nextMovies(0);
      isLoadingLatest = true;
      notifyListeners();
    }
  }
  nextMovies(int x){
    showList.clear();
    for(int i=0;i<5;i++){
      if(latestMoviesList[x].id != null){
      showList.add(latestMoviesList[x]);
      x++;
      }
    }
    notifyListeners();
  }
  setFavouriteById(id){
    for(int l = 0;l<latestMoviesList.length;l++){
      if(latestMoviesList[l].id==id){
          latestMoviesList[l].favourite=false;
      }
    }
    notifyListeners();
  }
  setCompareById(id){
    for(int l = 0;l<latestMoviesList.length;l++){
      if(latestMoviesList[l].id==id){
        latestMoviesList[l].compare=false;
      }
    }
    notifyListeners();
  }

}
