import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';





class AuthService {


static  final auth = FirebaseAuth.instance;


static  Future<Either<String, bool>> userLogin(
      {required String email, required String password}) async {
    try {
      final response = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(true);

    } on FirebaseAuthException catch (err) {
      return Left(err.message.toString());
    }
  }


static  Future<Either<String, bool>> userSignUp(
    {
      required String email,
      required String password,
      required String username,
      required XFile image
    }) async {
  try {
     final token = await FirebaseMessaging.instance.getToken();
     final ref = FirebaseStorage.instance.ref().child('userImage/${image.name}');
   await ref.putFile(File(image.path));
  final url = await ref.getDownloadURL();
    final response = await auth.createUserWithEmailAndPassword(
        email: email, password: password);


     await FirebaseChatCore.instance.createUserInFirestore(
       types.User(
         firstName: username,
         id: response.user!.uid,
         imageUrl: url,
         metadata: {
           'email': email,
           'token': token
         }
       ),
     );

    return Right(true);

  } on FirebaseAuthException catch (err) {
    return Left(err.message.toString());
  } on FirebaseException catch(err){
    return Left(err.message.toString());
  }
}


static  Future<Either<String, bool>> userLogOut() async {
  try {
    final response = await auth.signOut();
    return Right(true);

  } on FirebaseAuthException catch (err) {
    return Left(err.message.toString());
  }
}




}
