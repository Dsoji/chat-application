import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ice_chat/feature/feeds/model/post_model.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPostWithImage(String content, String imageUrl) async {
    final postsCollection = _firestore.collection('posts');
    final timestamp = DateTime.now();

    await postsCollection.add({
      'content': content,
      'timestamp': timestamp,
      'image_url': imageUrl,
    });
  }

  Stream<List<Post>> getPosts() {
    final postsCollection = _firestore.collection('posts');

    return postsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Post.fromMap(data);
      }).toList();
    });
  }

  Future<void> deletePost(String postId) async {
    final postReference = _firestore.collection('posts').doc(postId);
    await postReference.delete();
  }
}
