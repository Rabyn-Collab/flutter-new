import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutternew/models/movie.dart';

import '../api_execption.dart';
import '../models/meal.dart';

const apiKey = '2a0f926961d00c667e191a21c14461f8';

class MovieService {

static final dio = Dio();

  static Future<Either<String, List<Movie>>> getMovieByCategory({required String apiPath, required int page})async{
     try{
     final response = await dio.get(apiPath, queryParameters: {
       'api_key': apiKey,
       'page': page
     });
     final mil = {
       'page': 90,
       'results': []
     };

     final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
     return  Right(data);
     }on DioError  catch (err){
     return Left(DioException.getErrorText(err));
     }

  }


static Future<Either<String, List<Movie>>> getSearchMovie({required String apiPath, required String queryText})async{
  try{
    final response = await dio.get(apiPath, queryParameters: {
      'api_key': apiKey,
      'query': queryText
    });
    if((response.data['results'] as List).isEmpty){
      return Left('try using another keyword');
    }else{
      final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
      return  Right(data);
    }


  }on DioError  catch (err){
    return Left(DioException.getErrorText(err));
  }

}



}




class FoodService {

  static final dio = Dio();

  static Future<Either<String, Meal>> getMeals({required String query})async{
    try{
      final response = await dio.get('https://www.themealdb.com/api/json/v1/1/search.php', queryParameters: {
        's': query
      });

      final data = Meal.fromJson(response.data);
      return  Right(data);
    }on DioError  catch (err){
      return Left(DioException.getErrorText(err));
    }

  }



}