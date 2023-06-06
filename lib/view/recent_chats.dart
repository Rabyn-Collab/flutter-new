import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/provider/room_provider.dart';
import 'package:get/get.dart';

import 'chat_page.dart';


class RecentChats extends ConsumerWidget {
  const RecentChats({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final roomData = ref.watch(roomStream);
    return Scaffold(
        body: SafeArea(
            child: roomData.when(
                data: (data){
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final otherUser = data[index].users.firstWhere((element) => element.id != FirebaseAuth.instance.currentUser!.uid);
                      final currentUser = data[index].users.firstWhere((element) => element.id == FirebaseAuth.instance.currentUser!.uid);
                      return ListTile(
                        onTap: (){
                          Get.to(() => ChatPage(data[index], otherUser.metadata!['token'], currentUser.firstName!));
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data[index].imageUrl!),
                        ),
                        title: Text(data[index].name!),
                      );
                    }
                  );
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => Center(child: CircularProgressIndicator())
            )
        )
    );
  }
}
