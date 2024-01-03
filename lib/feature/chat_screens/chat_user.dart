import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/feature/chat_screens/chat_page.dart';
import 'package:ice_chat/feature/chat_screens/view_model/chatview_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ChatScreen(),
      );

  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
    super.initState();
    // Initialize the stream with all users
    _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Welcome, here are your chats',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Gap(24),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        onChanged: (query) {
                          // Call a function to filter users based on the search query
                          _filterUsers(query);
                        },
                        decoration: InputDecoration(
                          fillColor: mOnboardingColor1,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search Direct Messages',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: IconButton(
                            icon: const Icon(
                              Iconsax.search_normal,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(24),
            // List of political parties
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error, might be a network issue');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.bouncingBall(
                        color: mOnboardingColor1,
                        size: 25,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<Widget>(
                        future: _buildUserListItem(
                          context,
                          snapshot.data!.docs[index],
                        ),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.done) {
                            return userSnapshot.data!;
                          } else {
                            return Center(
                              child: LoadingAnimationWidget.bouncingBall(
                                color: mOnboardingColor1,
                                size: 25,
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// Function to filter users based on the search query
  void _filterUsers(String query) {
    // Update the stream based on the search query
    setState(() {
      _usersStream = FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .snapshots();
    });
  }

//
  Future<Widget> _buildUserListItem(
    BuildContext context,
    DocumentSnapshot document,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('userEmail') ?? '';
    String currentUserId = prefs.getString('userDocId') ?? '';

    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data != null) {
      String receiverUsername = data['name'] ?? '';
      String receiverId = data['userId'] ?? '';
      const String image = ''; // Set your default image here

      // Check if the userEmail is not equal to the receiver's email
      if (userEmail != data['email']) {
        return UserItem(
          userName: receiverUsername,
          recieverId: receiverId,
          senderId: currentUserId,
          onPressed: () {
            // Navigate to chat page or perform other actions
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  image: image,
                  text: receiverUsername,
                  recieverUsername: receiverUsername,
                  recieverId: receiverId,
                  senderId: currentUserId,
                ),
              ),
            );
          },
        );
      }
    }

    // Return an empty SizedBox if conditions are not met or data is null
    return const SizedBox();
  }

//
}
