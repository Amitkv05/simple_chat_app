import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simple_chat_app/Services/chat_service.dart';
import 'package:simple_chat_app/chat_screen/const/msg_bubble.dart';
import 'package:simple_chat_app/const/colors.dart';
import 'package:simple_chat_app/controllers/chats_controller.dart';

class MsgScreen extends StatefulWidget {
  const MsgScreen(
      {super.key,
      required this.receiverImage,
      required this.sendername,
      required this.receivername,
      required this.receiverUserEmail,
      required this.receiverUserId});
  final String? sendername;
  final String? receivername;
  final String receiverUserId;
  final String receiverUserEmail;
  final String receiverImage;

  @override
  State<MsgScreen> createState() => _MsgScreenState();
}

class _MsgScreenState extends State<MsgScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  void sendMessage() async {
    // only send message if there is something to send..
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text);
      // clear the text controller after sending the message...
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(ChatsController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            children: [
              Container(
                color: Colors.black,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      ClipOval(
                        child: CircleAvatar(
                          child: Image.network(
                            widget.receiverImage,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: '${widget.receivername}\n',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const TextSpan(
                            text: 'last seen',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ])),
                      ),
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.video_call,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.call, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildMessageItems(widget.receivername),

                      // TextFormField........

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    controller: _messageController,
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.emoji_emotions,
                                          color: Colors.yellowAccent,
                                        ),
                                        hintText: 'Type a Message...',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        suffixIcon: Icon(
                                          Icons.attachment,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                    onPressed: sendMessage,
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.blue,
                                    )),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageItems(receivername) {
    return Expanded(
      child: StreamBuilder(
          stream: _chatService.getMessages(
              widget.receiverUserId, FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text('Loading...'),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: snapshot.data!.docs
                  .map((document) => MsgBubble(
                        receivername: receivername,
                        receiverImage: widget.receiverImage,
                        document: document,
                      ))
                  .toList(),
            );
          }),
    );
    //const Expanded(child: MsgBubble());
  }
}
