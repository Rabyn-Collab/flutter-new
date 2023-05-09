import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutternew/models/movie.dart';

const apiKey = '2a0f926961d00c667e191a21c14461f8';

class MovieService {

static final dio = Dio();
  static Future<Either<String, List<Movie>>> getMovieByCategory({required String apiPath, required int page})async{
     try{
     final response = await dio.get(apiPath, queryParameters: {
       'api_key': apiKey,
       'page': page
     });

     final data = (response.data['results'] as List).map((e) => Movie.fromJson(e)).toList();
     return  Right(data);
     }on DioError  catch (err){
       print(err);
     return Left(err.toString());
     }

  }



}