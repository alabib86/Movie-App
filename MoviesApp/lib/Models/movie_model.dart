import 'dart:convert';

class MovieModel {
  String? title;
  int? id;
  String? posterPath;
  bool? favourite;
  bool? compare;

  MovieModel({this.title, this.id, this.posterPath, this.favourite, this.compare});

  factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
      title: json['original_title'],
      id: json['id'],
      posterPath: json['backdrop_path'],
      favourite: false,
      compare: false);

  static Map<String, dynamic> toMap(MovieModel movieModel) => {
        'original_title': movieModel.title,
        'id': movieModel.id,
        'backdrop_path': movieModel.posterPath,
        'favorite': movieModel.favourite,
        'compare': movieModel.compare,
      };

  static String encode(List<MovieModel> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>(
                (movieModel) => MovieModel.toMap(movieModel))
            .toList(),
      );

  static List<MovieModel> decode(String movies) =>
      (json.decode(movies) as List<dynamic>)
          .map<MovieModel>((item) => MovieModel.fromMap(item))
          .toList();
}
