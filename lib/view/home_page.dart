import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternew/view/detail_page.dart';
import 'package:get/get.dart';

import '../constants/sizes.dart';
import '../models/book.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F5F9),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F5F9),
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text('Hi John,'),
        actions: [
          Icon(CupertinoIcons.search),
          gapW10,
          Icon(CupertinoIcons.bell),
          gapW10
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.network(
                'https://plus.unsplash.com/premium_photo-1663047790964-a4565e24729f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Ym9va3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60', fit: BoxFit.cover,),
          ),
          SizedBox(height: 20,),
          Container(
            height: 250,
         child: ListView.builder(
             itemCount: books.length,
             scrollDirection: Axis.horizontal,
             itemBuilder: (context, index){
               final book = books[index];
              return InkWell(
                onTap: (){
                Get.to(() => DetailPage(book), transition: Transition.leftToRight);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 370,
                    child: Stack(
                      children: [
                        Card(
                          child: Row(
                            children: [
                              Spacer(),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(book.title),
                                        Text(book.detail, maxLines: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(book.rating),
                                            Text(book.genre)
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              SizedBox(width: 20,)
                            ],
                          ),
                        ),

                        Positioned(
                          top: 10,
                          left: 10,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(books[index].imageUrl, width: 150,height: 210,fit: BoxFit.fitHeight,)),
                        ),


                      ],
                    )
                ),
              );
             }
         ),
          ),
          SizedBox(height: 10,),

          Container(
            height: 300,
            child: ListView.builder(
                itemCount: books.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  final book = books[index];
                  return Container(
                      margin: EdgeInsets.only(right: 20),
                      width: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(books[index].imageUrl),
                          SizedBox(width: 20,),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(book.title),
                                SizedBox(height: 10,),
                                Text(book.genre),
                              ],
                            ),
                          )
                        ],
                      )
                  );
                }
            ),
          ),


        ],
      )
    );
  }
}
