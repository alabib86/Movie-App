import 'package:flutter/material.dart';

import '../Models/movie_model.dart';

class MovieWHorizontal extends StatelessWidget {
  const MovieWHorizontal({Key? key, required this.list}) : super(key: key);

  final List<MovieModel> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, i) {
            return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.blue),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              height: 200,
              width: 200,
              child: Column(
                children: [
                  const SizedBox(
                    height:5,
                  ),
                  Text("${list[i].title}"),
                  const SizedBox(
                    height:15,
                  ),
                  Image.network(
                    "https://image.tmdb.org/t/p/original${list[i].posterPath}",
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
                ],
              ),
            );
          }),
    );
  }
}
