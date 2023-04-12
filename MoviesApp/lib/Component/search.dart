import 'package:flutter/material.dart';
import 'package:movies_app/Providers/latest_movies_provider.dart';
import 'package:provider/provider.dart';

class DataSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List result =context
        .watch<LatestMoviesProvider>()
        .latestMoviesList
        .where((element) => element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    bool isSaved = true;
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
            children: [
              Text("${result[0].title}"),
              const SizedBox(
                height: 5,
              ),
              Image.network(
                "https://image.tmdb.org/t/p/original${result[0].posterPath}",
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              IconButton(
                icon: Icon(
                  isSaved ? Icons.favorite : Icons.favorite_border,
                  color: isSaved ? Colors.red : null,
                ),
                onPressed: () {},
              ),
            ],
          ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filter = context
        .watch<LatestMoviesProvider>()
        .latestMoviesList
        .where((element) => element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Consumer<LatestMoviesProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
            itemCount:
                query == "" ? provider.latestMoviesList.length : filter.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: (){
                  query == "" ? provider.latestMoviesList[i].title : filter[i].title;
                  showResults(context);
                },
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      child: query == ""
                          ? Text("${provider.latestMoviesList[i].title}")
                          : Text("${filter[i].title}")));
            });
      },
    );
  }
}
