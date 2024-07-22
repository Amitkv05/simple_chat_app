import 'package:flutter/material.dart';
import 'package:simple_chat_app/chat_screen/const/msg_bubble.dart';
import 'package:velocity_x/velocity_x.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  var message = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   backgroundColor: Colors.black,
        //   title: const Text(
        //     'UserName',
        //     // style: TextStyle(color: Colors.black),
        //   ),
        //   actions: [
        //     IconButton(
        //         onPressed: () {}, icon: const Icon(Icons.more_vert_outlined))
        //   ],
        // ),
        body: Container(
          margin: const EdgeInsets.only(top: 8),
          decoration: const BoxDecoration(
            // color: Colors.red,
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // appbar start.............
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: 'FriendName\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'last seen',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ]),
                      ),
                    ),
                    CircleAvatar(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.video_call_rounded,
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                // appbar Ends.............
                Divider(
                  color: Colors.grey[400],
                ),
                // msg Screen....
                Expanded(
                  child: msgBubble(),
                ),
                const SizedBox(height: 8),
                // Text Send......
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(248, 31, 30, 30),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextFormField(
                              // set message controller here
                              onSaved: (newValue) {
                                message = newValue!;
                              },
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.emoji_emotions_rounded,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.attachment_rounded,
                                    color: Colors.grey.shade600,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Type a Message..',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                    fontFamily: 'mont_semi',
                                  )),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // ontab of this send message
                          print(message.text);
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 238, 235, 190),
                          child: Icon(Icons.send),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
