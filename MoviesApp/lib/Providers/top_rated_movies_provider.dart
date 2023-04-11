import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/movie_model.dart';

const String _key = "cc5b812a11ac76a779e943b41a16756e";

class TopRatedProvider with ChangeNotifier {
  bool isLoadingTopRated = false;
  final String _topRated =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=";
  List<MovieModel> topRatedMoviesList = [];

  TopRatedProvider() {
    getTopRatedData();
  }

  getTopRatedData() async {
    String target = "$_topRated$_key";
    var url = Uri.parse(target);

    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var i in responseBody['results']) {
        topRatedMoviesList.add(MovieModel.fromMap(i));
      }
      isLoadingTopRated = true;
      notifyListeners();
    }
  }
}
