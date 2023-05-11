


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api.dart';
import '../models/movie_state.dart';
import '../services/movie_service.dart';

final searchProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(
    MovieState(errText: '', isLoad: false, isError: false, isSuccess: false, movies: [], page: 1, api: Api.searchMovie, isLoadMore: false)
));


class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider(super.state);




  Future<void> getSearchMovie({required String query})async{
    state = state.copyWith(isLoad: true, isError: false, isSuccess: false);
    final response = await MovieService.getSearchMovie(apiPath: state.api, queryText: query);
    response.fold(
            (l) => state = state.copyWith(isSuccess: false, isError: true, errText: l, isLoad: false, movies: []),
            (r) => state = state.copyWith(isSuccess: true, isError: false, errText: '', isLoad: false, movies: r)
    );
  }

}