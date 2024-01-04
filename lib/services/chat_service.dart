import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ice_chat/feature/chat_screens/model/chat_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final chatServiceProvider = ChangeNotifierProvider((ref) => ChatService());

final _logger = Logger();

class ChatService extends ChangeNotifier {
  // Get instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final ImagePicker _imagePicker = ImagePicker();

  // Existing methods...

  Future<XFile?> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      // Notify listeners if image is picked successfully
      if (pickedFile != null) {
        notifyListeners();
      }

      return pickedFile;
    } catch (e) {
      _logger.e('Error picking image: $e');
      return null;
    }
  }

  // Send message
  Future<void> sendMessage(
    String recieverId,
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
    Msg newMsg = Msg(
      senderId: currentUserId,
      senderUsername: currentUserName,
      recieverId: recieverId,
      message: message,
      timestamp: timestamp,
      imageUrl: imageUrl,
    );

    // Construct chat room id
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // Add new message to Firestore
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('messages')
        .add(newMsg.toMap());

    notifyListeners();
  }

  // Get messages
  Stream<QuerySnapshot> getMsg(String userId, String otherUserId) {
    // Construct chat room id
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Upload image to Firebase Storage and return download URL
  Future<String> uploadImageToFirebaseStorage(XFile image) async {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref('chat_images').child(image.path);

    await storageRef.putFile(File(image.path));
    final downloadUrl = await storageRef.getDownloadURL();

    return downloadUrl;
  }

  //get only last message of a specific chat
  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
