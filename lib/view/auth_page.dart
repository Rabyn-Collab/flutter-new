// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutternew/common/snack_show.dart';
// import 'package:flutternew/constants/sizes.dart';
// import 'package:flutternew/provider/auth_provider.dart';
// import 'package:flutternew/provider/common_provider.dart';
//
//
// class AuthPage extends ConsumerWidget {
//
//   final mailController = TextEditingController();
//   final  nameController = TextEditingController();
//   final passController = TextEditingController();
//
//   final _form = GlobalKey<FormState>();
//
//
//   @override
//   Widget build(BuildContext context, ref) {
//     ref.listen(authProvider, (previous, next) {
//         if(next.isError){
//           SnackShow.showFailure(context,next.errText);
//         }else if(next.isSuccess){
//           SnackShow.showSuccess(context, 'success');
//         }
//
//     });
//
//
// //     ref.listen(movieProvider, (previous, next) {
// //       if(next.title.isNotEmpty){
// //         SnackShow.showFailure(context, next.title);
// //       }
// //
// //     });
// //
// // final a = ref.watch(aPro);
//
//
//     final isLogin = ref.watch(loginProvider);
//     final auth = ref.watch(authProvider);
// final image = ref.watch(imageProvider);
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
//                     // Text(a.toString()),
//                     // TextButton(onPressed: (){
//                     //   ref.read(movieProvider.notifier).callData();
//                     // }, child: Text('change')),
//                     Text(isLogin ? 'User Login': 'User Register', style: TextStyle(fontSize: 20),),
//                     gapH20,
//                  if(!isLogin)  TextFormField(
//                      controller: nameController,
//                      validator: (val){
//                        if(val!.isEmpty){
//                          return 'please provide your name';
//                        }
//
//                        return null;
//                      },
//                      decoration: InputDecoration(
//                        border: OutlineInputBorder(),
//                        hintText: 'Your Name',
//                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
//                      ),
//                    ),
//                     gapH20,
//                    TextFormField(
//                      controller: mailController,
//                      keyboardType: TextInputType.emailAddress,
//                      validator: (val){
//                        bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val!);
//                        if(val.isEmpty){
//                          return 'please provide your email';
//                        }else if(!emailValid){
//                          return 'please provide valid email';
//                        }
//
//                        return null;
//                      },
//                      decoration: InputDecoration(
//                          border: OutlineInputBorder(),
//                          hintText: 'Your Email',
//                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
//                      ),
//                    ),
//                   gapH20,
//                    TextFormField(
//                      controller: passController,
//                      obscureText: true,
//                      validator: (val){
//                        if(val!.isEmpty){
//                          return 'please provide your password';
//                        }
//                        // else if( val.length < 5){
//                        //   return 'minimum character is  4';
//                        // }else if(val.length > 20){
//                        //   return 'maximum character is less than 20';
//                        // }
//
//                        return null;
//                      },
//                      // obscureText: true,
//                      decoration: InputDecoration(
//                          border: OutlineInputBorder(),
//                          hintText: 'Password',
//                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
//                      ),
//                    ),
//                     gapH20,
//                   if(!isLogin)  InkWell(
//                     onTap: (){
//                       ref.read(imageProvider.notifier).pickUImage(false);
//                     },
//                     child: Container(
//                         height: 100,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.white)
//                         ),
//                         child: image == null ? Center(child: Text('Please select an image'))
//                       : Image.file(File(image.path), fit: BoxFit.cover,),
//                       ),
//                   ),
//                     gapH20,
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(vertical: 5)
//                       ),
//                         onPressed: (){
//                         FocusScope.of(context).unfocus();
//                           _form.currentState!.save();
//                           if(_form.currentState!.validate()){
//                             // passController.text.replaceAll(" ", "");
//                             //  print(mailController.text.trim());
//                             //  print(passController.text.trim().replaceAll(" ", " "));
//                             if(isLogin){
//                             ref.read(authProvider.notifier).userLogin(
//                             email: mailController.text.trim(),
//                             password: passController.text.trim()
//                             );
//                           }else{
//
//
//                               if(image == null){
//                                 SnackShow.showFailure(context,'no images selected');
//                               }else{
//                                 ref.read(authProvider.notifier).userSignUp(
//                                     email: mailController.text.trim(),
//                                     password: passController.text.trim(),
//                                     username: nameController.text.trim(),
//                                     image: image
//                                 );
//
//                               }
//
//
//
//                             }
//
//                           }
//                         },
//                         child: auth.isLoad ? Center(child: CircularProgressIndicator(
//                           color: Colors.white,
//                         )): Text( isLogin ? 'Login' :'Sign Up')),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(isLogin ? 'Don\'t have an Account ?': 'Already have an Account'),
//                         TextButton(onPressed: (){
//                           ref.read(loginProvider.notifier).toggle();
//                         }, child: Text(isLogin ? 'Sign Up':  'Login'))
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         )
//     );
//   }
// }
