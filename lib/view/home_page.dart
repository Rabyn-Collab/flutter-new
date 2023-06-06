import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/common/snack_show.dart';
import 'package:flutternew/provider/auth_provider.dart';
import 'package:flutternew/provider/crud_provider.dart';
import 'package:flutternew/services/crud_service.dart';
import 'package:flutternew/view/create_post.dart';
import 'package:flutternew/view/recent_chats.dart';
import 'package:flutternew/view/update_page.dart';
import 'package:flutternew/view/user_page.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../constants/sizes.dart';
import '../notification_service.dart';
import '../services/auth_service.dart';
import 'detail_page.dart';

class HomePage extends ConsumerStatefulWidget {


  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

late types.User user;

@override
  void initState() {

  // 1. This method call when app in terminated state and you get a notification
  // when you click on notification app open from terminated state and you can get notification data in this method

  FirebaseMessaging.instance.getInitialMessage().then(
        (message) {
      if (message != null) {
        LocalNotificationService.createanddisplaynotification(message);
      }
    },
  );

  // // 2. This method only call when App in forground it mean app must be opened
  // FirebaseMessaging.onMessage.listen(
  //       (message) {
  //     if (message.notification != null) {
  //       print("message.data11 ${message.data}");
  //       LocalNotificationService.createanddisplaynotification(message);
  //
  //     }
  //   },
  // );

  // 3. This method only call when App in background and not terminated(not closed)
  FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        LocalNotificationService.createanddisplaynotification(message);
      }
    },
  );

    // getToken();
    super.initState();
  }


  void getToken () async{
  final response = await FirebaseMessaging.instance.getToken();
  print(response);
  }

  @override
  Widget build(BuildContext context) {
    final authData = FirebaseAuth.instance.currentUser;
    final userData = ref.watch(usersStream);
    final singleData = ref.watch(singleStream);
    final postData = ref.watch(postsStream);
    return Scaffold(
        drawer: Drawer(
            child: singleData.when(
                data: (data) {
                  user = data;
                  return ListView(
                    children: [
                      DrawerHeader(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data.imageUrl!),
                                  fit: BoxFit.cover)),
                          child: Container()),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.person),
                        title: Text(data.firstName!),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.mail),
                        title: Text(data.metadata!['email']),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          Get.to(() => CreatePage());
                        },
                        leading: Icon(Icons.add),
                        title: Text('Create Post'),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          Get.to(() => RecentChats());
                        },
                        leading: Icon(Icons.message),
                        title: Text('Recent Chats'),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          ref.read(authProvider.notifier).userLogOut();
                        },
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Log Out'),
                      )
                    ],
                  );
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => Center(child: CircularProgressIndicator()))),
        appBar: AppBar(
          title: Text('Social App'),
        ),
        body: Column(
          children: [
            Container(
              height: 150,
              child: userData.when(
                  data: (data) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Get.to(() => UserPage(data[index]));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(data[index].imageUrl!),
                                  ),
                                  gapH10,
                                  Text(data[index].firstName!)
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => Center(child: CircularProgressIndicator())),
            ),
            gapH20,
            Expanded(
                child: postData.when(
                    data: (data){
                      return Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: ListView.builder(
                          itemCount: data.length,
                            itemBuilder: (context, index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Text(data[index].title)),
                                    if(authData!.uid == data[index].userId) IconButton(
                                        onPressed: (){
                                          Get.defaultDialog(
                                            title: "Update",
                                            content: Text('Customize post'),
                                            actions: [
                                              IconButton(onPressed: (){
                                                Navigator.of(context).pop();
                                                Get.to(() => UpdatePage(data[index]));
                                              }, icon: Icon(Icons.edit)),
                                              IconButton(onPressed: (){
                                                Navigator.of(context).pop();
                                                Get.defaultDialog(
                                                    title: "Hold On",
                                                    content: Text('Are you sure'),
                                                    actions: [
                                                      TextButton(onPressed: (){
                                                        Navigator.of(context).pop();
                                                        ref.read(crudProvider.notifier).removePost(
                                                            postId: data[index].postId,
                                                            imageId: data[index].imageId
                                                        );
                                                      }, child: Text('Yes')),
                                                      TextButton(onPressed: (){
                                                        Navigator.of(context).pop();
                                                      }, child: Text('No')),

                                                    ]
                                                );



                                              }, icon: Icon(Icons.delete)),
                                            ]
                                          );
                                        }, icon: Icon(Icons.more_horiz_outlined))
                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.to(() => DetailPage(data[index], user));
                                  },
                                  child: Container(
                                      height: 300,
                                      child: Image.network(data[index].imageUrl)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(data[index].detail)),
                                    Row(
                                      children: [
                                        if(authData.uid != data[index].userId)   IconButton(
                                            onPressed: (){
                                              if(data[index].like.username.contains(user.firstName)){
                                              SnackShow.showFailure(context, 'you have already like this post');
                                              }else{
                                                ref.read(crudProvider.notifier).likePost(username: user.firstName!, postId: data[index].postId,
                                                    like: data[index].like.likes);
                                              }

                                            }, icon: Icon(Icons.thumb_up_alt_sharp)),
                                        if(data[index].like.likes > 0) Text(data[index].like.likes.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            );
                            }
                        ),
                      );
                    },
                    error: (err, stack) => Center(child: Text('$err')),
                    loading: () => Center(child: CircularProgressIndicator())
                )
            )

          ],
        ));
  }
}
