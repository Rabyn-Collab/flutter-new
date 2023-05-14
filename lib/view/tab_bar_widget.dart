import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/models/movie.dart';
import 'package:flutternew/models/movie_state.dart';
import 'package:flutternew/provider/movie_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutternew/view/detail_page.dart';
import 'package:get/get.dart';
import 'package:flutter_offline/flutter_offline.dart';


class TabBarWidget extends StatelessWidget {
  final MovieCategory movieCategory;
  final String pageKey;
  const TabBarWidget({Key? key, required this.movieCategory, required this.pageKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        connectivityBuilder: ( BuildContext context,
        ConnectivityResult connectivity,
        Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected ? Consumer(
              builder: (context, ref, child) {
                final movieState = movieCategory == MovieCategory.popular ? ref
                    .watch(popularProvider) :
                movieCategory == MovieCategory.topRated ? ref.watch(
                    topRatedProvider) : ref.watch(upcomingProvider);
                if (movieState.isLoad) {
                  return Center(child: CircularProgressIndicator());
                } else if (movieState.isError) {
                  return Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${movieState.errText}'),
                      ElevatedButton(onPressed: (){
                        ref.invalidate(popularProvider);
                        ref.invalidate(topRatedProvider);
                        ref.invalidate(upcomingProvider);
                      }, child: Text(connected ? 'Resume': 'No Connection'))
                    ],
                  ));
                } else {
                  return  Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: NotificationListener(
                          onNotification: (
                              ScrollEndNotification onNotification) {
                            final before = onNotification.metrics.extentBefore;
                            final max = onNotification.metrics.maxScrollExtent;
                            if (before == max) {
                              if (movieCategory == MovieCategory.popular) {
                                ref.read(popularProvider.notifier).LoadMore();
                              } else
                              if (movieCategory == MovieCategory.topRated) {
                                ref.read(topRatedProvider.notifier).LoadMore();
                              } else {
                                ref.read(upcomingProvider.notifier).LoadMore();
                              }
                            }
                            return true;
                          },
                          child: GridView.builder(
                              key: PageStorageKey<String>(pageKey),
                              itemCount: movieState.movies.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 7,
                                  childAspectRatio: 2 / 3
                              ),
                              itemBuilder: (context, index) {
                                final movie = movieState.movies[index];

                                return InkWell(
                                  onTap: () {
                                    Get.to(() => DetailPage(movie));
                                  },
                                  child: CachedNetworkImage(
                                    errorWidget: (c, s, d) =>
                                        Image.asset('assets/images/movie.png'),
                                    placeholder: (context, url) =>
                                        SpinKitFadingCube(
                                          color: Colors.pink,
                                          size: 50.0,
                                        ),
                                    imageUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie
                                        .poster_path}',
                                  ),
                                );
                              }

                          ),
                        ),
                      ) ;

                }
              }
          ) : Center(child: Text('No Internet'));
        },
      child: Container(),
    );
  }
}
