import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/common/snack_show.dart';
import 'package:flutternew/constants/sizes.dart';
import 'package:flutternew/model/post.dart';
import 'package:flutternew/provider/common_provider.dart';
import 'package:flutternew/provider/crud_provider.dart';
import 'package:get/get.dart';


class UpdatePage extends ConsumerStatefulWidget {
final Post post;
UpdatePage(this.post);
  @override
  ConsumerState<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends ConsumerState<UpdatePage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController detailController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    titleController..text = widget.post.title;
    detailController..text = widget.post.detail;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(crudProvider, (previous, next) {
      if(next.isError){
        SnackShow.showFailure(context,next.errText);
      }else if(next.isSuccess){
        SnackShow.showSuccess(context, 'success');
        Get.back();
      }

    });

    final crud = ref.watch(crudProvider);
    final image = ref.watch(imageProvider);
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    gapH20,
                    TextFormField(
                      controller: titleController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Title',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    gapH20,
                    TextFormField(
                      controller: detailController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide your detail';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Detail',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    gapH20,
                    InkWell(
                      onTap: (){
                        ref.read(imageProvider.notifier).pickUImage(false);
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)
                        ),
                        child: image == null ? Image.network(widget.post.imageUrl)
                            : Image.file(File(image.path), fit: BoxFit.cover,),
                      ),
                    ),
                    gapH20,
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 5)
                        ),
                        onPressed: (){
                          FocusScope.of(context).unfocus();
                          _form.currentState!.save();
                          if(_form.currentState!.validate()){


                            if(image == null){
                            ref.read(crudProvider.notifier).updatePost(
                                title: titleController.text.trim(),
                                detail: detailController.text.trim(),
                                postId: widget.post.postId
                            );
                            }else{
                              ref.read(crudProvider.notifier).updatePost(
                                  title: titleController.text.trim(),
                                  detail: detailController.text.trim(),
                                  postId: widget.post.postId,
                                image: image,
                                imageId: widget.post.imageId
                              );

                            }


                          }
                        },
                        child: crud.isLoad ? Center(child: CircularProgressIndicator(
                          color: Colors.white,
                        )): Text('Submit')),

                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
