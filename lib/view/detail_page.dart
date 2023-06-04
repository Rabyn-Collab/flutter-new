import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/common/snack_show.dart';
import 'package:flutternew/constants/sizes.dart';
import 'package:flutternew/provider/crud_provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutternew/services/crud_service.dart';
import '../model/post.dart';



class DetailPage extends StatelessWidget {
final Post post;
final types.User user;
DetailPage(this.post, this.user);
final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Consumer(
            builder: (context, ref, child) {
              final allPost = ref.watch(postsStream);
              return Column(
                children: [
                  Image.network(post.imageUrl),
                  gapH20,
                  TextFormField(
                    controller: commentController,
                    onFieldSubmitted: (val) {
                      if (val.isEmpty || val.length < 16) {
                        SnackShow.showFailure(context,
                            'minimum 15 characters required');
                      } else {
                         ref.read(crudProvider.notifier).addComment(
                             comment: Comment(
                                 username: user.firstName!,
                                 image: user.imageUrl!,
                                 comment:val.trim()
                             ),
                             postId: post.postId
                         );
                      }
                      commentController.clear();
                    },
                    decoration: InputDecoration(
                        hintText: 'add comment',
                        border: OutlineInputBorder()
                    ),
                  ),
                  Expanded(
                      child: allPost.when(
                          data: (data){
                            final thisPost = data.firstWhere((element) => element.postId == post.postId);
                            return ListView.builder(
                                itemCount: thisPost.comments.length,
                                itemBuilder: (context, index){
                                  final comment = thisPost.comments[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(comment.image),
                                    ),
                                    title: Text(comment.username),
                                    subtitle: Text(comment.comment),
                                  );
                                }
                            );
                          },
                          error: (err, stack) => Text('$err'),
                          loading: () => Center(child: CircularProgressIndicator())
                      )
                  )
                ],
              );
            }
          ),
        )
    );
  }
}
