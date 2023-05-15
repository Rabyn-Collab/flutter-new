import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutternew/provider/food_provider.dart';
import 'package:get/get.dart';

import '../provider/serach_provider.dart';
import 'meal_video.dart';


class MealPage extends StatelessWidget {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final mealState =  ref.watch(mealProvider);
          return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        onFieldSubmitted: (val){
                          ref.read(mealProvider.notifier).getMeal(query: val.trim());
                          searchController.clear();
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            hintText: 'search meal',
                            border: OutlineInputBorder()
                        ),
                      ),
                      Expanded(
                          child: mealState.isLoad ? Center(child: CircularProgressIndicator()): mealState.isError ?
                          Center(child: Text(mealState.errText)) :
                         mealState.meal != null ? GridView.builder(
                              itemCount: mealState.meal?.meals.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 7,
                                  childAspectRatio: 2/3
                              ),
                              itemBuilder: (context, index){
                                final meal = mealState.meal?.meals[index];
                                return  InkWell(
                                  onTap: (){
                                    Get.to(() => MealVideo(url: meal.strYoutube,));
                                  },
                                  child: CachedNetworkImage(
                                    errorWidget: (c, s, d) => Image.asset('assets/images/movie.png'),
                                    placeholder: (context, url) => SpinKitFadingCube(
                                      color: Colors.pink,
                                      size: 50.0,
                                    ),
                                    imageUrl: meal!.strMealThumb,
                                  ),
                                );
                              }

                          ): Text('')
                      )
                    ],
                  ),
                ),
              )
          );
        }
    );
  }
}
