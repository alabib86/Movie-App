import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/movie_model.dart';

const String _key = "cc5b812a11ac76a779e943b41a16756e";

class UpcomingMoviesProvider with ChangeNotifier {

  bool isLoadingUpcoming = false;
  final String _upcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=";
  List<MovieModel> upcomingMoviesList=[];

  UpcomingMoviesProvider(){getUpcomingData();}

  getUpcomingData() async {
    String target = "$_upcoming$_key";
    var url = Uri.parse(target);

    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      for (var i in responseBody['results']) {
        upcomingMoviesList.add(MovieModel.fromMap(i));
      }
      isLoadingUpcoming=true;
      notifyListeners();
    }
  }
}