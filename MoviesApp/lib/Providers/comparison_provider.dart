import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/Models/detaild_movie_model.dart';

const String _key = "?api_key=cc5b812a11ac76a779e943b41a16756e";

class ComparisonProvider with ChangeNotifier {
  String moviesId = "";
  final String _detailed = "https://api.themoviedb.org/3/movie/";
  List<DetailedMovieModel> comparisonList = [];

  getDetailedDataToComparisonList(String id) async {
    moviesId = id;
    String target = "$_detailed$moviesId$_key";
    var url = Uri.parse(target);

    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      DetailedMovieModel d = DetailedMovieModel();
      d.title = responseBody['original_title'];
      d.posterPath = responseBody['poster_path'];
      d.id = responseBody['id'];
      d.releaseDate = responseBody['release_date'];
      d.originCountry =
          responseBody['production_companies'][0]['origin_country'];
      d.overview = responseBody['overview'];
        comparisonList.add(d);
    }
    notifyListeners();
  }
  deleteFromComparisonListById(id){
    comparisonList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
