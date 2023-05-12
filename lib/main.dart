import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutternew/provider/count_provider.dart';
import 'package:flutternew/view/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<String> getSome() async{
  return Future.delayed(Duration(seconds: 2), (){
    return 'hello world';
  });
}

Future getNews() async{
  final dio = Dio();
  try{
    final response = await dio.get('https://free-news.p.rapidapi.com/v1/search',
    queryParameters: {
      'q': 'hollywood',
      'lang': 'en'
    },
      options: Options(
        headers: {
          'X-RapidAPI-Key': '89e53c72d7msh16aa8c041814a4cp1f3e79jsn333d7bcaf747',
          'X-RapidAPI-Host': 'free-news.p.rapidapi.com'
        }
      )
    );
    return response.data;
  }on DioError  catch (err){
    return err.response;
  }
}


Future getTopRated() async{
  final dio = Dio();
  try{
    final response = await dio.get('https://api.themoviedb.org/3/movie/top_rated',
        queryParameters: {
          'api_key': '2a0f926961d00c667e191a21c14461f8',
          'page': 1
        },
    );
    return response.data;
  }on DioError  catch (err){
    return err.response;
  }
}


void main () async {
  final random = Random();
  await Future.delayed(Duration(milliseconds: 500));
 // final data = await getNews();
 // final data1 = await getTopRated();
 // print(data1);
 //   // getSome().then((value) => print(value)).catchError((err) => print(err));




 runApp(ProviderScope(child: Home()));

}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData.dark(),
   debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class Count extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(),
        body: Consumer(
          builder: (context, ref, child) {
            final m = ref.watch(count);
            return ListView(
              children: [
                Center(child: Text('$m', style: TextStyle(fontSize: 50),)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          ref.read(count.notifier).state++;
                        }, child: Text('add')),
                    TextButton(onPressed: () {

                    }, child: Text('decre')),
                  ],
                )
              ],
            );
          }
        )
    );
  }
}


