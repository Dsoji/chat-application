import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String senderId;
  final String senderUsername;
  final String message;
  final Timestamp timestamp;
  final String? imageUrl; // Added imageUrl field

  Posts({
    required this.senderId,
    required this.senderUsername,
    required this.message,
    required this.timestamp,
    this.imageUrl, // Added imageUrl parameter with default value null
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      senderId: json['senderId'],
      senderUsername: json['senderUsername'],
      message: json['message'],
      timestamp: json['timestamp'],
      imageUrl: json['imageUrl'],
    );
  }

  // Converting to map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderUsername': senderUsername,
      'message': message,
      'timestamp': timestamp,
      'imageUrl': imageUrl, // Added imageUrl to the map
    };
  }
}
