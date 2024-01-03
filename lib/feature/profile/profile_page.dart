import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/core/constants/appTexts.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/core/util/date_util.dart';
import 'package:ice_chat/feature/auth_screen/login_screen.dart';
import 'package:ice_chat/feature/profile/edit_profile.dart';
import 'package:ice_chat/services/post_Service.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String currentUserId;
  final PostService _postService = PostService();

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<Map<String, String>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userName = prefs.getString('userName') ?? '';
    String userEmail = prefs.getString('userEmail') ?? '';
    currentUserId = prefs.getString('userId') ?? '';

    return {
      'userName': userName,
      'userEmail': userEmail,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Settings',
            style: TextStyle(
                fontSize: 20,
                color: mOnboardingColor1,
                fontWeight: FontWeight.w600)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: mOnboardingColor1),
              onPressed: () {
                logout(context);
              },
              child: const Icon(
                Iconsax.logout,
                size: 21,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getUserDetails(),
          builder: (context, snapshot) {
            Map<String, String> userDetails =
                snapshot.data as Map<String, String>;
            if (snapshot.hasError) {
              return Text('Error ${snapshot.error}');
            }
            if (snapshot.data!.isNotEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(22),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Gap(10),
                          SizedBox(
                            height: double.infinity,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " ${userDetails['userName']}",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.regular24.copyWith(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Gap(10),
                                Text(
                                  " ${userDetails['userEmail']}",
                                  style: AppTextStyles.regular16.copyWith(
                                    color: mTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfile()),
                                );
                              },
                              child: Text('EDIT',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: mOnboardingColor1,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(25),
                  const Divider(),
                  const Center(
                    child: Text('Your Feeds',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                  const Divider(),
                  Expanded(
                    child: _buildMessageList(),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('Say Hii! 👋',
                    style: TextStyle(
                      fontSize: 20,
                      color: mOnboardingColor1,
                    )),
              );
            }
          }),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    Timestamp timestamp = data['timestamp'];
    DateTime dateTime = timestamp.toDate();
    String formattedDateTime = DateFormat('h:mm a').format(dateTime);
    // DocumentReference userDocRef =
    //     _firestore.collection('users').doc(widget.senderId);

    // String documentId = userDocSnapshot.id;
    // String senderId = data['senderId'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(4),
                Text(
                  "${data['senderUsername']} ",
                  style: TextStyle(
                      fontSize: 16,
                      color: mOnboardingColor1,
                      fontWeight: FontWeight.bold),
                ),
                const Gap(4),
                Container(
                  height: 4,
                  width: 4,
                  decoration: BoxDecoration(
                    color: mOnboardingColor1,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const Gap(4),
                Text(
                  MyDateUtil.getFormattedTime(
                      context: context, time: data['timestamp']),
                  style: TextStyle(fontSize: 13, color: mOnboardingColor1),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    color: mOnboardingColor1,
                    icon: const Iconify(
                      Majesticons.more_menu_line,
                    )),
              ],
            ),
            const Divider(),
            const Gap(2),
            if (data['imageUrl'] != null &&
                data['imageUrl'].toString().isNotEmpty)
              Container(
                // constraints: const BoxConstraints(maxWidth: 250),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),

                width: double.infinity,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CachedNetworkImage(
                    imageUrl: data['imageUrl'],
                    placeholder: ((context, url) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        )),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image_not_supported_outlined,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 5.0),
            if (data['message'] != null &&
                data['message'].toString().isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${data['message']}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            Divider(
              thickness: 3,
              color: mOnboardingColor1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _postService.getUserPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: mOnboardingColor1, size: 25));
        }
        if (snapshot.data!.docs.isNotEmpty) {
          // Filter messages based on the current user ID
          // final filteredDocs = snapshot.data!.docs
          //     .where((doc) => doc['senderId'] == ' ${currentUserId}')
          //     .toList();

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return _buildMessageItem(snapshot.data!.docs[index]);
            },
            reverse: false,
            physics: const BouncingScrollPhysics(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child:
                  Text('👋 Navigate to the feeds page to make your first post!',
                      style: TextStyle(
                        fontSize: 20,
                        color: mOnboardingColor1,
                      )),
            ),
          );
        }
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    // Show a loading indicator if needed
    // CircularProgressIndicator();

    await FirebaseAuth.instance.signOut();

    // Clear the user details using the userDetails['userRole']Provider's clearUserDetails method.
    // Provider.of<userDetails['userRole']Provider>(context, listen: false).clearUserDetails();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userName');
    prefs.remove('userDocId');
    prefs.remove('userEmail');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
