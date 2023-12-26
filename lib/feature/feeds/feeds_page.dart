import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/core/util/date_util.dart';
import 'package:ice_chat/core/widgets/reusable_buttons.dart';
import 'package:ice_chat/services/post_Service.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({super.key});

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  late Future<Map<String, String>> _userDetails;
  late String _userId;
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<Map<String, String>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userName = prefs.getString('userName') ?? '';
    String userEmail = prefs.getString('userEmail') ?? '';
    // String userId = prefs.getString('userDocId') ?? '';
    _userId = prefs.getString('userDocId') ?? '';
    return {
      'userName': userName,
      'userEmail': userEmail,
      'userDocId': _userId,
    };
  }

  final TextEditingController _postController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PostService _postService = PostService();
  XFile? _selectedImage;

  void sendPost() async {
    final String textMessage = _postController.text.trim();
    final XFile? selectedImage = _selectedImage;

    // Allow sending a message even if only text exists and no image
    await _postService.makePosts(
      _userId,
      textMessage,
      selectedImage,
    );

    _postController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 60.0,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    final XFile? pickedImage = await _postService.pickImage();
                    if (pickedImage != null) {
                      setState(() {
                        _selectedImage = pickedImage;
                      });
                    }
                  },
                  icon: const Icon(Iconsax.gallery),
                  color: mOnboardingColor1,
                ),
                Expanded(
                  child: TextField(
                    controller: _postController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: mOnboardingColor1,
                      hintText: 'What would you like to share?',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          SmallIconButton(
            onPressed: sendPost,
            highcolor: mOnboardingColor1,
            color: Colors.white,
            icon: const Icon(Iconsax.send_2),
            thisighcolor: mOnboardingColor1,
          ),
        ],
      ),
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
    String senderId = data['senderId'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20.0),
          //     border: Border.all(
          //       color: mOnboardingColor1,
          //       width: 2,
          //     )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blue,
                    // backgroundImage: AssetImage(profileImage),
                  ),
                  const Gap(4),
                  Text(
                    "'${data['senderUsername']} '",
                    style: TextStyle(fontSize: 15, color: mOnboardingColor1),
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
                    "${MyDateUtil.getFormattedTime(context: context, time: data['timestamp'])}",
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 5.0),

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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _postService.getPosts(),
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
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return _buildMessageItem(snapshot.data!.docs[index]);
            },
            reverse: true,
            physics: const BouncingScrollPhysics(),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        leading: const Row(
          children: [
            Gap(16),
            CircleAvatar(
              backgroundColor: Colors.blue,
            ),
          ],
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Feeds',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          const Gap(12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildMessageInput(),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildMessageList(),
          ),
        ],
      ),
    );
  }
}
