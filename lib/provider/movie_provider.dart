import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/api.dart';
import 'package:flutternew/models/movie_state.dart';
import 'package:flutternew/services/movie_service.dart';



final popularProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(
  MovieState(errText: '', isLoad: false, isError: false, isSuccess: false, movies: [], page: 1, api: Api.getPopular)
));


final topRatedProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(
    MovieState(errText: '', isLoad: false, isError: false, isSuccess: false, movies: [], page: 1, api: Api.getTopRated)
));


final upcomingProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(
    MovieState(errText: '', isLoad: false, isError: false, isSuccess: false, movies: [], page: 1, api: Api.getUpcoming)
));


class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider(super.state){
   getMovieByCategory();
  }


  Future<void> getMovieByCategory()async{
    state = state.copyWith(isLoad: true, isError: false, isSuccess: false);
    final response = await MovieService.getMovieByCategory(apiPath: state.api, page: state.page);
    response.fold(
            (l) => state = state.copyWith(isSuccess: false, isError: true, errText: l, isLoad: false, movies: []),
            (r) => state = state.copyWith(isSuccess: true, isError: false, errText: '', isLoad: false, movies: r)
    );
  }




}