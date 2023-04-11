import 'package:flutter/material.dart';
import 'package:movies_app/Component/movie_widget_vertical.dart';
import 'package:movies_app/Providers/latest_movies_provider.dart';
import 'package:movies_app/Providers/top_rated_movies_provider.dart';
import 'package:movies_app/Providers/upcoming_movies_provider.dart';
import 'package:provider/provider.dart';

import '../Component/movie_widget_horizontal.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  static int index=0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(height: 10,),
            const Text("Upcoming Movies"),
            const SizedBox(height: 10,),
            Consumer<UpcomingMoviesProvider>(builder: (context, prov, child) {
              return
                prov.isLoadingUpcoming == false
                    ? const Center(child: CircularProgressIndicator())
                    : MovieWHorizontal(list: prov.upcomingMoviesList,);
            }),
            const SizedBox(height: 30,),
            const Text("Top Rated Movies"),
            const SizedBox(height: 10,),
            Consumer<TopRatedProvider>(builder: (context, prov, child) {
              return
                prov.isLoadingTopRated == false
                    ? const Center(child: CircularProgressIndicator())
                    : MovieWHorizontal(list: prov.topRatedMoviesList,);
            }),
            const SizedBox(height: 30,),
            const Text("Latest Movies"),
            const SizedBox(height: 10,),
            Consumer<LatestMoviesProvider>(builder: (context, prov, child) {
              return
                prov.isLoadingLatest == false
                    ? const Center(child: CircularProgressIndicator())
                    : MovieWVertical(list: prov.showList,);
            }),
            Consumer<LatestMoviesProvider>(
              builder: (context, provider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {
                      if(index>0){
                        provider.nextMovies(index-=5);
                      }else{}
                    },
                      icon: const Icon(Icons.arrow_circle_left),
                      color: Colors.blue,),
                    IconButton(onPressed: () {
                      if(index<provider.latestMoviesList.length) {
                        provider.nextMovies(index += 5);
                      }else{}
                    },
                      icon: const Icon(Icons.arrow_circle_right),
                      color: Colors.blue,)
                  ],
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
