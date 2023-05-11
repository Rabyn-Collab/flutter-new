import 'package:flutter/material.dart';
import 'package:flutternew/models/movie_state.dart';
import 'package:flutternew/view/search_page.dart';
import 'package:flutternew/view/tab_bar_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Movie Tmdb', style: TextStyle(fontSize: 20, color: Colors.amber),),
                  IconButton(onPressed: (){
                    Get.to(() => SearchPage());
                  }, icon: Icon(Icons.search, size: 25,))
                ],
              ),
            ),
          ),
          bottom: TabBar(

            indicator: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(10)
            ),
              tabs: [
            Tab(
              text: 'Popular',
            ),
            Tab(
              text: 'Top_Rated',
            ),
            Tab(
              text: 'UpComing',
            ),
          ]
          ),
        ),
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
           TabBarWidget(movieCategory: MovieCategory.popular, pageKey: 'popular'),
           TabBarWidget(movieCategory: MovieCategory.topRated, pageKey: 'topRated'),
           TabBarWidget(movieCategory: MovieCategory.upcoming, pageKey: 'upComing'),
          ])
      ),
    );
  }
}
