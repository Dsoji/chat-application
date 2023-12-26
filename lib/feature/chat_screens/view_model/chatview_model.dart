import 'package:flutter/material.dart';
import 'package:ice_chat/core/constants/colors.dart';
import 'package:ice_chat/core/util/date_util.dart';
import 'package:ice_chat/feature/chat_screens/model/chat_model.dart';
import 'package:ice_chat/services/chat_service.dart';

class UserItem extends StatefulWidget {
  final String userName;
  final String recieverId;
  final String senderId;
  final void Function()? onPressed;

  const UserItem({
    super.key,
    required this.userName,
    this.onPressed,
    required this.recieverId,
    required this.senderId,
  });

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  // final String image = Assets.fk22;
  Msg? _message;

  final ChatService _chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _chatService.getLastMessage(widget.recieverId, widget.senderId),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;
          final list = data?.map((e) => Msg.fromJson(e.data())).toList() ?? [];
          if (list.isNotEmpty) _message = list[0];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage(''),
                    radius: 29.0,
                  ),
                  title: Text(
                    widget.userName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    _message != null
                        ? (_message?.imageUrl != null &&
                                _message!.imageUrl!.isNotEmpty)
                            ? 'Image'
                            : _message?.message ??
                                'no message yet' // Use null-aware operator here
                        : 'no message yet',
                    maxLines: 1,
                    style: TextStyle(color: mTextColor2),
                  ),

                  trailing: _message == null
                      ? const Text('👋')
                      : _message!.senderId != widget.senderId
                          ? Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: mTextColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          : //message sent time
                          Text(
                              MyDateUtil.getLastMessageTime(
                                  context: context, time: _message!.timestamp),
                              style: const TextStyle(color: Colors.black54),
                            ),

                  onTap: widget.onPressed,
                  // () {
                  //   // Navigator.push(
                  //   //   context,
                  //   //   MaterialPageRoute(
                  //   //     builder: (context) => ChatPage(
                  //   //       image: image,
                  //   //       text: userName,
                  //   //     ),
                  //   //   ),
                  //   // );
                  // },
                ),
              ],
            ),
          );
        });
  }
}
