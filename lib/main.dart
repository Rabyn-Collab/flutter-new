import 'package:flutter/material.dart';
import 'package:flutternew/view/home_page.dart';
import 'package:get/get.dart';



void main (){

 runApp(Home());

}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
   debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class MediaSample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
        body: SafeArea( 
          child: Column(
            children: [
              Container(
                  width: width * 0.5,
                  height: height * 0.25,
                  color: Colors.black87,
              ), Container(
                  width: width * 0.5,
                  height: height * 0.25,
                  color: Colors.amber,
              ), Container(
                  width: width * 0.5,
                  height: height * 0.25,
                  color: Colors.tealAccent,
              ), Container(
                  width: width * 0.5,
                  height: height * 0.25,
                  color: Colors.pink,
              ),
            ],
          ),
        )
    );
  }
}




class StackSample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.blueGrey,
          ),
            Positioned(
              left: 20,
              child: Container(
                height: 90,
                width: 90,
                color: Colors.red,
              ),
            ),
            Positioned(
              top: 20,
              child: Container(
                height: 90,
                width: 90,
                color: Colors.amberAccent,
              ),
            ),
            Positioned(
              top: 60,
              left: 90,
              child: Container(
                height: 90,
                width: 90,
                color: Colors.black87,
              ),
            )
          ],
        ),
      ),
    );
  }
}




