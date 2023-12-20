import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

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
        leading: BackButton(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black, // <-- SEE HERE
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Here are your chats',
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
            const Divider(),
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
                          // _filterUsers(query);
                        },
                        decoration: InputDecoration(
                          fillColor: mTextColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search Direct Messages',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: IconButton(
                            icon: const Icon(
                              Iconsax.search_normal,
                              color: Colors.black,
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

            // Expanded(
            //   child: StreamBuilder<QuerySnapshot>(
            //     stream: _usersStream,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasError) {
            //         return const Text('Error, might be a network issue');
            //       }

            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(
            //           child: LoadingAnimationWidget.staggeredDotsWave(
            //             color: Colors.black0,
            //             size: 25,
            //           ),
            //         );
            //       }

            //       return ListView.builder(
            //         itemCount: snapshot.data!.docs.length,
            //         itemBuilder: (context, index) {
            //           return FutureBuilder<Widget>(
            //             future: _buildUserListItem(
            //               context,
            //               snapshot.data!.docs[index],
            //             ),
            //             builder: (context, userSnapshot) {
            //               if (userSnapshot.connectionState ==
            //                   ConnectionState.done) {
            //                 return userSnapshot.data!;
            //               } else {
            //                 return Center(
            //                   child: LoadingAnimationWidget.staggeredDotsWave(
            //                     color: Colors.black0,
            //                     size: 25,
            //                   ),
            //                 );
            //               }
            //             },
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Function to filter users based on the search query
  // void _filterUsers(String query) {
  //   // Update the stream based on the search query
  //   setState(() {
  //     _usersStream = FirebaseFirestore.instance
  //         .collection('users')
  //         .where('username', isGreaterThanOrEqualTo: query)
  //         .snapshots();
  //   });
  // }

  // Build individual user list item
  // Future<Widget> _buildUserListItem(
  //     BuildContext context, DocumentSnapshot document) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String email = prefs.getString('email') ?? '';
  //   String userId = prefs.getString('id') ?? '';

  //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  //   if (email != data['email']) {
  //     final String receiverUsername = data['username'];
  //     final String receiverId = data['id'];
  //     const String image = Assets.pfp1;
  //     return UserItem(
  //       userName: receiverUsername,
  //       recieverId: receiverId,
  //       senderId: userId,
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ChatPage(
  //               image: image,
  //               text: receiverUsername,
  //               recieverUsername: receiverUsername,
  //               recieverId: receiverId,
  //               senderId: userId,
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   } else {
  //     return const SizedBox();
  //   }
  // }
}
