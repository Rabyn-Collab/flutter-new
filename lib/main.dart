import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';




void main () async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

