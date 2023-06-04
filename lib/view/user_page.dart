import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/constants/sizes.dart';
import 'package:flutternew/view/chat_page.dart';
import 'package:get/get.dart';

import '../provider/room_provider.dart';
import '../services/crud_service.dart';
import 'detail_page.dart';

class UserPage extends ConsumerWidget {
final types.User user;

UserPage(this.user);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.imageUrl!),

                    ),
                    gapW10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.firstName!),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(user.metadata!['email']),
                        ),
                        ElevatedButton(
                            onPressed: () async{
                          final response = await ref.read(roomProvider).createRoom(user);
                          if(response != null){
                            Get.to(() => ChatPage(response, user));
                          }
                        }, child: Text('Start Chat'))
                      ],
                    )
                  ],
                ),
                Expanded(child: Consumer(
                    builder: (context, ref, child){
                      final allposts = ref.watch(postsStream);
                      return allposts.when(
                          data: (data){
                            final userPost = data.where((element) => element.userId == user.id).toList();
                            return GridView.builder(
                                itemCount: userPost.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  childAspectRatio: 2/3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10
                                ),
                                itemBuilder: (context, index){
                                  return InkWell(
                                      onTap: (){
                                        Get.to(() => DetailPage(userPost[index], user));
                                      },
                                      child: Image.network(userPost[index].imageUrl!));
                                }
                            );

                          },
                          error: (err, stack){
                            return Text('$err');
                          },
                          loading: () => Center(child: CircularProgressIndicator())
                      );
                    }
                ))

              ],
            ),
          ),
        )
    );
  }
}
