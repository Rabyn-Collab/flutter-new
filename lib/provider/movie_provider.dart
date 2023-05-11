import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/api.dart';
import 'package:flutternew/models/movie_state.dart';
import 'package:flutternew/services/movie_service.dart';



final popularProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(
  MovieState(errText: '', isLoad: false, isError: false, isSuccess: false, movies: [], page: 1, api: Api.getPopular, isLoadMore: false)
));


final topRatedProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(
    MovieState(errText: '', isLoad: false, isError: false, isSuccess: false, movies: [], page: 1, api: Api.getTopRated, isLoadMore: false)
));


final upcomingProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(
    MovieState(errText: '', isLoad: false, isError: false, isSuccess: false, movies: [], page: 1, api: Api.getUpcoming, isLoadMore: false)
));


class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider(super.state){
   getMovieByCategory();
  }


  Future<void> getMovieByCategory()async{
    state = state.copyWith(isLoad: state.isLoadMore ? false:  true, isError: false, isSuccess: false);
    final response = await MovieService.getMovieByCategory(apiPath: state.api, page: state.page);
    response.fold(
            (l) => state = state.copyWith(isSuccess: false, isError: true, errText: l, isLoad: false, movies: []),
            (r) => state = state.copyWith(isSuccess: true, isError: false, errText: '', isLoad: false,
                movies: [...state.movies, ...r]
            )
    );
  }


  Future<void> LoadMore()async{
    state = state.copyWith(page: state.page + 1, isLoadMore: true);
    getMovieByCategory();
  }



}