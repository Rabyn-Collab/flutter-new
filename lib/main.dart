import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutternew/status_page.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();


}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "High_importance_channel",
  "High_importance_channel",
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const InitializationSettings initializationSettings =
InitializationSettings(
  android: AndroidInitializationSettings("@mipmap/ic_launcher"),
);

void main () async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(channel);
flutterLocalNotificationsPlugin.initialize(
initializationSettings
);

 runApp(ProviderScope(child: Home()));

}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData.dark(),
   debugShowCheckedModeBanner: false,
   home: StatusPage(),
    );
  }
}


class Counter extends StatelessWidget {
   Counter({Key? key}) : super(key: key);

  final numberStream = StreamController<int>();
   int numbers = 90 + 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<int>(
          stream: numberStream.stream,
          builder: (context, snapshot) {
            return Center(
                child: Text(snapshot.data.toString(), style: TextStyle(fontSize: 50),)
            );
          }
        ),
    floatingActionButton: FloatingActionButton(
        onPressed: (){
          numberStream.sink.add(numbers++);
        },
      child: Icon(Icons.add),
    ),
    );
  }
}


