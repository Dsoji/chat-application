import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/core/providers.dart';
import 'package:image_picker/image_picker.dart';

class FeedsPage extends ConsumerWidget {
  const FeedsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModelProvider);
    // Access the StateController for selectedImage
    final selectedImageController = ref.read(selectedImageProvider);

    // Access the current state of the selectedImage
    final selectedImage = selectedImageController.state;

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Take a look at some feeds',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 9.0),
            child: ElevatedButton(
              onPressed: () async {
                PickedFile? pickedFile;

                // Use conditional imports to handle platform differences
                if (Platform.isIOS || Platform.isAndroid) {
                  pickedFile = await viewModel.pickImage() as PickedFile?;
                } else {
                  // Handle unsupported platform or use a fallback method
                  print('Unsupported platform');
                }

                // Update the state of selectedImage using the StateController
                selectedImageController.state = pickedFile;
              },
              child: const Text('Make a Post'),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: PostList(),
          ),
        ],
      ),
    );
  }
}

class PostList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use ref.watch to observe the AsyncValue
    final asyncPosts = ref.watch(postListProvider);

    return asyncPosts.when(
      loading: () =>
          const CircularProgressIndicator(), // Show loading indicator if data is loading
      error: (error, stack) =>
          Text('Error: $error'), // Show error message if an error occurs
      data: (posts) {
        // Extract the data from AsyncValue
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return ListTile(
              title: Text(post.content),
              subtitle: Text('Posted on: ${post.timestamp}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  // Use ref.read to access homeViewModelProvider and call deletePost
                  await ref.read(homeViewModelProvider)?.deletePost(post.id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
