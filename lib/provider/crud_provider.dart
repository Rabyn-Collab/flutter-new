// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutternew/model/common_state.dart';
// import 'package:flutternew/services/crud_service.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../model/post.dart';
//
//
// final crudProvider = StateNotifierProvider<CrudProvider,CommonState>((ref) => CrudProvider(
//     CommonState(
//         isLoad: false,
//         isSuccess: false,
//         isError: false,
//         errText: ''
//     )));
//
// class CrudProvider extends StateNotifier<CommonState>{
//   CrudProvider(super.state);
//
//
//
//  Future<void> addPost(
//       {
//         required String title,
//         required String detail,
//         required String userId,
//         required XFile image
//       }) async {
//    state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
//    final response = await CrudService.addPost(title: title, detail: detail, userId: userId, image: image);
//    response.fold((l) {
//      state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
//    }, (r) {
//      state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
//    });
//
//   }
//
//
//     Future<void> removePost(
//       {
//         required String postId,
//         required String imageId
//       }) async {
//       state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
//       final response = await CrudService.removePost(postId: postId, imageId: imageId);
//       response.fold((l) {
//         state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
//       }, (r) {
//         state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
//       });
//   }
//
//
//     Future<void> updatePost(
//       {
//         required String title,
//         required String detail,
//         required String postId,
//         XFile? image,
//         String? imageId
//       }) async {
//       state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
//       final response = await CrudService.updatePost(
//           title: title,
//           detail: detail,
//           postId: postId,
//         image: image,
//         imageId: imageId
//       );
//       response.fold((l) {
//         state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
//       }, (r) {
//         state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
//       });
//
//   }
//
//
//     Future<void> likePost(
//       {
//         required String username,
//         required String postId,
//         required int like
//       }) async {
//       state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
//       final response = await CrudService.likePost(username: username, postId: postId, like: like);
//       response.fold((l) {
//         state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
//       }, (r) {
//         state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
//       });
//     }
//
//
//
//    Future<void> addComment(
//       {
//         required Comment comment,
//         required String postId,
//       }) async {
//      state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
//      final response = await CrudService.addComment(comment: comment, postId: postId);
//      response.fold((l) {
//        state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
//      }, (r) {
//        state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
//      });
//    }
//
//
//
// }