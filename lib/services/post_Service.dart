import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ice_chat/feature/feeds/model/post_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:ice_chat/feature/feeds/model/post_model.dart';
class PostService extends ChangeNotifier {
  // Get instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final ImagePicker _imagePicker = ImagePicker();

  // Existing methods...

  Future<XFile?> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      return pickedFile;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  // Send message
  Future<void> makePosts(
    String userId,
    String message,
    XFile? image,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userDocId') ?? '';
    String username = prefs.getString('userName') ?? '';

    // Get current user info
    final String currentUserId = userId;
    final String currentUserName = username;
    final Timestamp timestamp = Timestamp.now();

    // Upload image if present and get URL
    String imageUrl = '';
    if (image != null) {
      imageUrl = await uploadImageToFirebaseStorage(image);
    }

    // Create a new message
    Posts newMsg = Posts(
      senderId: currentUserId,
      senderUsername: currentUserName,
      message: message,
      timestamp: timestamp,
      imageUrl: imageUrl,
    );

    // Construct chat room id
    List<String> ids = [currentUserId];
    ids.sort();
    // String chatRoomId = ids.join("_");

    // Add new message to Firestore
    await _firestore.collection("posts").add(newMsg.toMap());
  }

  // Get posts
  Stream<QuerySnapshot> getPosts() {
    // Construct chat room id

    return _firestore
        .collection("posts")
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  //get user posts
  Stream<QuerySnapshot> getUserPosts() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userDocId');
    // Assuming _firestore is an instance of FirebaseFirestore
    yield* _firestore
        .collection("posts")
        .where('senderId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Upload image to Firebase Storage and return download URL
  Future<String> uploadImageToFirebaseStorage(XFile image) async {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref('post_images').child(image.path);

    await storageRef.putFile(File(image.path));
    final downloadUrl = await storageRef.getDownloadURL();

    return downloadUrl;
  }

  //get only last message of a specific chat
  Stream<QuerySnapshot<Map<String, dynamic>>> getLastPost(
      String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    // String chatRoomId = ids.join("_");

    return _firestore
        .collection("posts")
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
