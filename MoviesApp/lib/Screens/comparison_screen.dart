import 'package:flutter/material.dart';
import 'package:movies_app/Providers/comparison_provider.dart';
import 'package:movies_app/Providers/latest_movies_provider.dart';
import 'package:provider/provider.dart';

class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({Key? key}) : super(key: key);

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ComparisonProvider, LatestMoviesProvider>(
        builder: (context, comProv, latestProv, child) {
      return comProv.comparisonList.isEmpty? const Center(child: Text("Add Movies...."))
          : ListView.builder(
              padding: const EdgeInsets.all(5),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: comProv.comparisonList.length,
              itemBuilder: (context, i) {
                return Container(
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(5)),
                        color: Colors.blue),
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                            title: const Text("Movie Name :"),
                            trailing: Text(
                                "${comProv.comparisonList[i].title}")),
                        const SizedBox(
                          height: 5,
                        ),
                        Image.network(
                          "https://image.tmdb.org/t/p/original${comProv.comparisonList[i].posterPath}",
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress
                                                .expectedTotalBytes!
                                        : null,
                              ),
                            );
                          },
                        ),
                        ListTile(
                            title: const Text("Release Date :"),
                            trailing: Text(
                                "${comProv.comparisonList[i].releaseDate}")),
                        const SizedBox(
                          height: 5,
                        ),
                        ListTile(
                            title: const Text("Origin Country :"),
                            trailing: Text(
                                "${comProv.comparisonList[i].originCountry}")),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text("Overview :"),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                                "${comProv.comparisonList[i].overview}")),
                        const SizedBox(
                          height: 5,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                          ),
                          onPressed: () {
                            latestProv.setCompareById(comProv.comparisonList[i].id);
                            comProv.deleteFromComparisonListById(
                                comProv.comparisonList[i].id);
                          },
                        )
                      ],
                    ));
              });
    });
  }
}
