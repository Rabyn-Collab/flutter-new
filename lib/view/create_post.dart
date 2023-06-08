// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutternew/common/snack_show.dart';
// import 'package:flutternew/constants/sizes.dart';
// import 'package:flutternew/provider/auth_provider.dart';
// import 'package:flutternew/provider/common_provider.dart';
// import 'package:flutternew/provider/crud_provider.dart';
// import 'package:get/get.dart';
//
//
// class CreatePage extends ConsumerWidget {
//
//   final titleController = TextEditingController();
//   final  detailController = TextEditingController();
//
//   final _form = GlobalKey<FormState>();
//
//
//   @override
//   Widget build(BuildContext context, ref) {
//     ref.listen(crudProvider, (previous, next) {
//       if(next.isError){
//         SnackShow.showFailure(context,next.errText);
//       }else if(next.isSuccess){
//         SnackShow.showSuccess(context, 'success');
//         Get.back();
//       }
//
//     });
//
//     final crud = ref.watch(crudProvider);
//     final image = ref.watch(imageProvider);
//     return Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _form,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     gapH20,
//                     TextFormField(
//                       controller: titleController,
//                       validator: (val){
//                         if(val!.isEmpty){
//                           return 'please provide title';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Title',
//                           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
//                       ),
//                     ),
//                     gapH20,
//                     TextFormField(
//                       controller: detailController,
//                       validator: (val){
//                         if(val!.isEmpty){
//                           return 'please provide your detail';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Detail',
//                           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
//                       ),
//                     ),
//                     gapH20,
//                     InkWell(
//                       onTap: (){
//                         ref.read(imageProvider.notifier).pickUImage(false);
//                       },
//                       child: Container(
//                         height: 100,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white)
//                         ),
//                         child: image == null ? Center(child: Text('Please select an image'))
//                             : Image.file(File(image.path), fit: BoxFit.cover,),
//                       ),
//                     ),
//                     gapH20,
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(vertical: 5)
//                         ),
//                         onPressed: (){
//                           FocusScope.of(context).unfocus();
//                           _form.currentState!.save();
//                           if(_form.currentState!.validate()){
//
//
//                               if(image == null){
//                                 SnackShow.showFailure(context,'no images selected');
//                               }else{
//                                  ref.read(crudProvider.notifier).addPost(
//                                      title: titleController.text.trim(),
//                                      detail: detailController.text.trim(),
//                                      userId: FirebaseAuth.instance.currentUser!.uid,
//                                      image: image
//                                  );
//
//                               }
//
//
//                           }
//                         },
//                         child: crud.isLoad ? Center(child: CircularProgressIndicator(
//                           color: Colors.white,
//                         )): Text('Submit')),
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         )
//     );
//   }
// }
