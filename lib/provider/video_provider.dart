import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/models/video.dart';

import '../services/movie_service.dart';


final videoProvider = FutureProvider.family((ref, int id) => VideoProvider.getVideoKey(id: id));

class VideoProvider {

  static final dio = Dio();

 static Future<List<Video>> getVideoKey({required int id}) async{
     try{
       final response = await dio.get('https://api.themoviedb.org/3/movie/$id/videos', queryParameters: {
         'api_key': apiKey,
       });
       final data = (response.data['results'] as List).map((e) => Video.fromJson(e)).toList();
       return data;
     }on DioError catch (err){
       throw '$err';
     }
  }
}