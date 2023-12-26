// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final postViewModelProvider = Provider<PostViewModel, PostRepository>((ref, repository) {
//   return PostViewModel(repository);
// });


// class PostViewModel {
//   final PostRepository _repository;

//   PostViewModel(this._repository);

//   Future<void> addPost(String text) async {
//     await _repository.addPost(text);
//   }

//   Stream<QuerySnapshot> getPosts() {
//     return _repository.getPosts();
//   }
// }