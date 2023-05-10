import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/models/movie_state.dart';
import 'package:flutternew/provider/movie_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class TabBarWidget extends StatelessWidget {
  final MovieCategory movieCategory;
  const TabBarWidget({Key? key, required this.movieCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final movieState = movieCategory == MovieCategory.popular ?  ref.watch(popularProvider):
          movieCategory == MovieCategory.topRated ? ref.watch(topRatedProvider): ref.watch(upcomingProvider);
          if(movieState.isLoad){
            return Center(child: CircularProgressIndicator());
          }else if(movieState.isError){
            return Center(child: Text('${movieState.errText}'));
          }else{
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: movieState.movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 7,
                    childAspectRatio: 2/3
                  ),
                  itemBuilder: (context, index){
                  final movie = movieState.movies[index];
                  return  CachedNetworkImage(
                    placeholder: (context, url) => SpinKitFadingCube(
                      color: Colors.pink,
                      size: 50.0,
                    ),
                    imageUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.poster_path}',
                  );
                  }

              ),
            );
          }
        }
    );
  }
}
