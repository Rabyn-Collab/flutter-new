import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/provider/room_provider.dart';
import 'package:image_picker/image_picker.dart';


class ChatPage extends ConsumerWidget {
final types.Room room;
final String token;
final String currentUserName;

ChatPage(this.room, this.token, this.currentUserName);

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
                  onAttachmentPressed: () async{
                    final pickImage = ImagePicker();
                    pickImage.pickImage(source: ImageSource.gallery).then((image) async {
                              if(image != null){
                                final ref = FirebaseStorage.instance.ref().child('chatImage/${image.name}');
                                await ref.putFile(File(image.path));
                                final url = await ref.getDownloadURL();
                                FirebaseChatCore.instance.sendMessage(
                                    types.PartialImage(
                                      name: image.name,
                                      size: File(image.path).lengthSync(),
                                      uri: url
                                    ), room.id);
                              }
                    }
                    );

                  },
                  onSendPressed: (types.PartialText message) async{
                    final dio = Dio();
                    try{
                      final response = await dio.post('https://fcm.googleapis.com/fcm/send',
                          data: {
                            "notification": {
                              "title": currentUserName,
                              "body": message.text,
                              "android_channel_id": "High_importance_channel"
                            },
                            "to": token

                          }, options: Options(
                              headers: {
                                HttpHeaders.authorizationHeader : 'key=AAAAzfi3vJw:APA91bHkftoiRKCRgcyONObGDLFijORJIdmzIByeJZEC0bZmxi39U-oL25rMBzlP1aeuj9vARr9H1p4r-QolYjuD2x0NSsMe6KFc0E4EmFjBGix6nnyqFhPavbfncz9_kj7BQ-LQc39w'
                              }
                          )
                      );
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
