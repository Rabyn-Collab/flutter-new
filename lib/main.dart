import 'package:flutter/material.dart';
import 'package:flutternew/view/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main (){

 runApp(ProviderScope(child: Home()));

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
