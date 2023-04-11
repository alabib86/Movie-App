import 'package:flutter/material.dart';
import 'package:movies_app/Providers/comparison_provider.dart';
import 'package:movies_app/Providers/favourite_provider.dart';
import 'package:provider/provider.dart';
import '../Models/movie_model.dart';

class MovieWVertical extends StatelessWidget {
  const MovieWVertical({Key? key, required this.list,}) : super(key: key);
  final List<MovieModel> list;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, i) {
            return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.blue),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Text("${list[i].title}"),
                  const SizedBox(height: 5,),
                  Image.network(
                    "https://image.tmdb.org/t/p/original${list[i].posterPath}",
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
                  Consumer2<FavouriteProvider,ComparisonProvider>(
                    builder: (context, favProv,compProv, child) {
                      for(var i in favProv.favouriteList){
                        for(int x =0;x<list.length;x++){
                          if(i.id==list[x].id){
                            list[x].favourite=true;
                          }
                        }
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(icon: Icon(
                            list[i].favourite==true ? Icons.favorite : Icons.favorite_border,
                            color: list[i].favourite==true ? Colors.red : null,
                          ), onPressed: () {
                            if(list[i].favourite==false ){
                             favProv.addToFav(list[i].id,"${list[i].title}","${list[i].posterPath}");
                             list[i].favourite=true;
                            }else{
                                 favProv.deleteFromFavById(list[i].id);
                                 list[i].favourite=false;
                            }
                          },),
                          IconButton(icon: Icon(Icons.compare,
                            color: list[i].compare==true? Colors.red:null
                          ),onPressed: (){
                            if( list[i].compare==false){
                              if(compProv.comparisonList.length<= 1){
                              compProv.getDetailedDataToComparisonList("${list[i].id}");
                              list[i].compare=true;}else{ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Already Choose, Please Go To Comparison Page"))
                              );}
                            }else{
                              compProv.deleteFromComparisonListById(list[i].id);
                              list[i].compare=false;
                            }
                          }, )
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
