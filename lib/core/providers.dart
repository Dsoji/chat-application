// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ice_chat/feature/feeds/model/post_model.dart';
// import 'package:ice_chat/feature/feeds/viewModels/feeds_viewmodel.dart';
// import 'package:ice_chat/services/imagePicker_service.dart';
// import 'package:ice_chat/services/post_Service.dart';
// import 'package:image_picker/image_picker.dart';

// // StateProvider using StateController to handle PickedFile state
// final selectedImageProvider =
//     StateProvider<StateController<PickedFile?>>((ref) {
//   return StateController<PickedFile?>(null);
// });

// // Provider for ImagePickerService
// final imagePickerServiceProvider = Provider<ImagePickerService>((ref) {
//   return ImagePickerService();
// });

// // Provider for PostService
// final postServiceProvider = Provider<PostService>((ref) {
//   return PostService();s
// });

// // StreamProvider for fetching the list of posts
// final postListProvider = StreamProvider<List<Post>>((ref) {
//   // Using ?. to handle potential null value of homeViewModelProvider
//   return ref.watch(homeViewModelProvider)?.getPosts() ?? Stream.value([]);
// });

// // Provider for HomeViewModel
// final homeViewModelProvider = Provider<HomeViewModel>((ref) {
//   return HomeViewModel(
//     imagePickerService: ref.read(imagePickerServiceProvider),
//     postService: ref.read(postServiceProvider),
//   );
// });
