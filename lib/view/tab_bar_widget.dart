import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/movie_provider.dart';


class TabBarWidget extends StatelessWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final movieState = ref.watch(movieProvider);

          if(movieState.isLoad){
            return Center(child: CircularProgressIndicator());
          }else if(movieState.isError){
            return Text('${movieState.errText}');
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
                  return Image.network('https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.poster_path}');
                  }

              ),
            );
          }
        }
    );
  }
}
