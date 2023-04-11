import 'package:flutter/material.dart';
import 'package:movies_app/Providers/favourite_provider.dart';
import 'package:movies_app/Providers/latest_movies_provider.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<FavouriteProvider,LatestMoviesProvider>(builder: (context,favProv,latestProv,child){
      return favProv.favouriteList.isEmpty? const Center(child: Text("Add Movie to Favourite")):
          ListView.builder(
            itemCount: favProv.favouriteList.length,
              itemBuilder: (context,i){
              return Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.blue),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text("${favProv.favouriteList[i].title}"),
                    const SizedBox(height: 5,),
                    Image.network(
                      "https://image.tmdb.org/t/p/original${favProv.favouriteList[i].posterPath}",
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes !=
                                null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5,),
                    IconButton(onPressed: (){
                      latestProv.setFavouriteById(favProv.favouriteList[i].id);
                      favProv.deleteFromFavById(favProv.favouriteList[i].id);
                    }, icon: const Icon(Icons.delete))
                  ],
                ),
              );
              }
          );
    });
  }
}
