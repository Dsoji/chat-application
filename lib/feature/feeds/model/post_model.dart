import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String content;
  final String imageUrl;
  final DateTime timestamp;

  Post({
    required this.id,
    required this.content,
    required this.imageUrl,
    required this.timestamp,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      content: map['content'],
      imageUrl: map['image_url'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
