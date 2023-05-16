import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




void main () async {

 runApp(ProviderScope(child: Home()));

}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData.dark(),
   debugShowCheckedModeBanner: false,

    );
  }
}

