import 'movie.dart';

enum MovieCategory{
  popular,
  topRated,
  upcoming
}


class MovieState{

  final List<Movie> movies;
  final bool isLoad;
  final bool isError;
  final String errText;
  final bool isSuccess;
  final int page;
  final String api;


  MovieState({
   required this.errText,
   required this.isLoad,
   required this.isError,
   required this.isSuccess,
   required this.movies,
    required this.api,
    required this.page,
});


  MovieState copyWith({
    List<Movie>? movies,
    bool? isLoad,
    bool? isError,
    String? errText,
    bool? isSuccess,
    int? page,
    String? api
}){
    return MovieState(
        errText: errText ?? this.errText,
        isLoad: isLoad ?? this.isLoad,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
        movies: movies ?? this.movies,
      api: api ?? this.api,
      page: page ?? this.page
    );
  }




}