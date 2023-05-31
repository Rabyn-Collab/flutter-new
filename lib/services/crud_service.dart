import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';





class CrudService {


  static  final postDb = FirebaseFirestore.instance.collection('posts');


  static  Future<Either<String, bool>> addPost(
      {
        required String title,
        required String detail,
        required String userId,
        required XFile image
      }) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('postImage/${image.name}');
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      final response = await postDb.add({
        'title': title,
        'detail': detail,
        'userId': userId,
        'imageUrl': url,
        'imageId': image.name,
        'like':{
          'likes': 0,
          'usernames': []
        },
        'comments': []
      });

      return Right(true);

    }on FirebaseException catch(err){
      return Left(err.message.toString());
    }
  }


  static  Future<Either<String, bool>> removePost(
      {
        required String postId,
        required String imageId
      }) async {
    try {

      final ref = FirebaseStorage.instance.ref().child('postImage/$imageId');
      await ref.delete();
      final response = await postDb.doc(postId).delete();
      return Right(true);
    }on FirebaseException catch(err){
      return Left(err.message.toString());
    }
  }






  static  Future<Either<String, bool>> updatePost(
      {
        required String title,
        required String detail,
        required String postId,
        XFile? image,
        String? imageId
      }) async {
    try {

      if(image == null){
        await postDb.doc(postId).update({
          'title': title,
          'detail': detail
        });
      }else{
        final ref = FirebaseStorage.instance.ref().child('postImage/$imageId');
        await ref.delete();
        final ref1 = FirebaseStorage.instance.ref().child('postImage/${image.name}');
        await ref1.putFile(File(image.path));
        final url = await ref1.getDownloadURL();
        final response = await postDb.doc(postId).update({
          'title': title,
          'detail': detail,
          'imageUrl': url,
          'imageId': image.name,
        });

      }


      return Right(true);

    }on FirebaseException catch(err){
      return Left(err.message.toString());
    }
  }






}
