import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/core/util/date_util.dart';
import 'package:ice_chat/core/widgets/reusable_buttons.dart';
import 'package:ice_chat/services/chat_service.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatPage extends StatefulWidget {
  final String text;
  final String image;
  final String recieverId;
  final String recieverUsername;
  final String senderId;

  const ChatPage({
    Key? key,
    required this.text,
    required this.image,
    required this.recieverId,
    required this.recieverUsername,
    required this.senderId,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _msgController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ChatService _chatService = ChatService();
  XFile? _selectedImage;

  void sendMsg() async {
    final String textMessage = _msgController.text.trim();
    final XFile? selectedImage = _selectedImage;

    // Allow sending a message even if only text exists and no image
    await _chatService.sendMessage(
      widget.recieverId,
      textMessage,
      selectedImage,
    );

    _msgController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    Timestamp timestamp = data['timestamp'];
    DateTime dateTime = timestamp.toDate();
    String formattedDateTime = DateFormat('h:mm a').format(dateTime);
    DocumentReference userDocRef =
        _firestore.collection('users').doc(widget.senderId);

    // String documentId = userDocSnapshot.id;
    String senderId = data['senderId'];

    var alignment = (widget.senderId == senderId)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: alignment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data['message'] != null && data['message'].toString().isNotEmpty)
            Container(
              constraints: const BoxConstraints(maxWidth: 250),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: widget.senderId == senderId
                    ? mOnboardingColor1
                    : const Color.fromARGB(255, 96, 108, 133),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                data['message'],
                maxLines: 50,
                style: TextStyle(
                  fontSize: 16.0,
                  color:
                      widget.senderId == senderId ? Colors.white : Colors.black,
                ),
              ),
            ),
          if (data['imageUrl'] != null &&
              data['imageUrl'].toString().isNotEmpty)
            Container(
              // constraints: const BoxConstraints(maxWidth: 250),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: widget.senderId == senderId
                        ? mOnboardingColor1
                        : mOnboardingColor1,
                    width: 4,
                  )),
              height: 330,
              width: 270,
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
          Text(
            MyDateUtil.getFormattedTime(
                context: context, time: data['timestamp']),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMsg(widget.recieverId, widget.senderId),
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
                    final XFile? pickedImage = await _chatService.pickImage();
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
                    controller: _msgController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: mOnboardingColor1,
                      hintText: 'Enter a message',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          SmallIconButton(
            onPressed: sendMsg,
            highcolor: mOnboardingColor1,
            color: Colors.white,
            icon: const Icon(Iconsax.send_2),
            thisighcolor: mOnboardingColor1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : mOnboardingColor1,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: CircleAvatar(
          backgroundImage: AssetImage(widget.image),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : mOnboardingColor1,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }
}
