import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ice_chat/core/providers.dart';
import 'package:ice_chat/feature/feeds/model/post_model.dart';
import 'package:ice_chat/services/imagePicker_service.dart';
import 'package:ice_chat/services/post_Service.dart';
import 'package:image_picker/image_picker.dart';

class HomeViewModel {
  final ImagePickerService _imagePickerService;
  final PostService _postService;

  HomeViewModel({
    required ImagePickerService imagePickerService,
    required PostService postService,
  })  : _imagePickerService = imagePickerService,
        _postService = postService;

  Future<Future<XFile?>> pickImage() async {
    return _imagePickerService.pickImage();
  }

  Future<void> addPostWithImage(String content, String imageUrl) async {
    await _postService.addPostWithImage(content, imageUrl);
  }

  Stream<List<Post>> getPosts() {
    return _postService.getPosts();
  }

  Future<void> deletePost(String postId) async {
    await _postService.deletePost(postId);
  }
}
