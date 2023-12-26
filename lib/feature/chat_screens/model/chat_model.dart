import 'package:cloud_firestore/cloud_firestore.dart';

class Msg {
  final String senderId;
  final String senderUsername;
  final String recieverId;
  final String message;
  final Timestamp timestamp;
  final String? imageUrl; // Added imageUrl field

  Msg({
    required this.senderId,
    required this.senderUsername,
    required this.recieverId,
    required this.message,
    required this.timestamp,
    this.imageUrl, // Added imageUrl parameter with default value null
  });
  
factory Msg.fromJson(Map<String, dynamic> json) {
  return Msg(
    senderId: json['senderId'],
    senderUsername: json['senderUsername'],
    recieverId: json['recieverId'],
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
      'recieverId': recieverId,
      'message': message,
      'timestamp': timestamp,
      'imageUrl': imageUrl, // Added imageUrl to the map
    };
  }
}
