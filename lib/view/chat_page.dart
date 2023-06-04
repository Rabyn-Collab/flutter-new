import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/provider/room_provider.dart';


class ChatPage extends ConsumerWidget {
final types.Room room;
final types.User user;

ChatPage(this.room, this.user);

  @override
  Widget build(BuildContext context, ref) {
    final msgStream = ref.watch(messageStream(room));
    return Scaffold(
        body: SafeArea(
          child: msgStream.when(
              data: (data){
                return Chat(
                  messages: data,
                  showUserAvatars: true,
                  showUserNames: true,
                  onSendPressed: (types.PartialText message){
                    try{
                      FirebaseChatCore.instance.sendMessage(message, room.id);
                    }on FirebaseException catch(err){
                       print(err);
                    } catch (err){
                      print(err);

                    }


                  },
                  user: types.User(
                      id: FirebaseAuth.instance.currentUser!.uid
                  ),
                );
              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: () => Center(child: CircularProgressIndicator())
          ),
        )
    );
  }
}
