import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/Services/store_service.dart';
import 'package:simple_chat_app/const/firebase_data.dart';

class MsgBubble extends StatelessWidget {
  const MsgBubble(
      {super.key,
      required this.document,
      required this.receivername,
      required this.receiverImage});
  final DocumentSnapshot document;
  final String receivername;
  final String receiverImage;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Directionality(
      // Lets fix who send the message..
      textDirection: document['senderId'] == currentUser!.uid
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: _buildCurrentUserName(),
      // ),
    );
  }

  FutureBuilder<dynamic> _buildCurrentUserName() {
    return FutureBuilder(
        future: StoreService.getUser(user!.uid),
        builder: (context, snapshot) {
          final isMe = document['senderId'] == currentUser!.uid;
          if (snapshot.hasData) {
            var CurrentUserdata = snapshot.data!.docs[0];

            return Stack(
              children: [
                ClipOval(
                  child: CircleAvatar(
                    child: document['senderId'] == currentUser!.uid
                        ? Image.network(
                            CurrentUserdata['userImage'],
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            receiverImage,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (document['senderId'] != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 13,
                                right: 13,
                              ),
                              child: document['senderId'] == currentUser!.uid
                                  ? Text(CurrentUserdata['username'])
                                  : Text(receivername),
                            ),
                        ],
                      ),
                      // const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              //  doc['uid'] == currentUser!.uid
                              // ?
                              // Colors.black,
                              // :
                              const Color.fromARGB(181, 62, 37, 0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            // 'hello',
                            '${document['message']}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          // time,
                          "2:00 Am",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        });
  }
}

/*
return Column(
                children: [
                  // if (CurrentUserdata['userImage'] != null)
                  ClipOval(
                    child: CircleAvatar(
                      radius: 23,
                      child: document['senderId'] == currentUser!.uid
                          ? Image.network(
                              CurrentUserdata['userImage'],
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              receiverImage,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Container(
                    // Add some margin to the edges of the messages, to allow space for the
                    // user's image.
                    margin: const EdgeInsets.symmetric(horizontal: 46),
                    child: Row(
                      // The side of the chat screen the message should show at.
                      // mainAxisAlignment:
                      //     isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        Column(
                          // crossAxisAlignment: isMe
                          //     ? CrossAxisAlignment.end
                          //     : CrossAxisAlignment.start,
                          children: [
                            // First messages in the sequence provide a visual buffer at
                            // the top.
                            // if (isFirstInSequence) const SizedBox(height: 18),
                            // if (username != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 13,
                                right: 13,
                              ),
                              child: isMe
                                  ? Text(
                                      CurrentUserdata['username'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    )
                                  : Text(
                                      receivername,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                            ),

                            // The "speech" box surrounding the message.
                            Container(
                              decoration: BoxDecoration(
                                color: isMe ? Colors.red[300] : Colors.green,
                                // Only show the message bubble's "speaking edge" if first in
                                // the chain.
                                // Whether the "speaking edge" is on the left or right depends
                                // on whether or not the message bubble is the current user.
                                borderRadius: BorderRadius.only(
                                  topLeft: !isMe
                                      ? Radius.zero
                                      : const Radius.circular(12),
                                  topRight: isMe
                                      ? Radius.zero
                                      : const Radius.circular(12),
                                  bottomLeft: const Radius.circular(12),
                                  bottomRight: const Radius.circular(12),
                                ),
                              ),
                              // Set some reasonable constraints on the width of the
                              // message bubble so it can adjust to the amount of text
                              // it should show.
                              constraints: const BoxConstraints(maxWidth: 200),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 14,
                              ),
                              // Margin around the bubble.
                              margin: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 12,
                              ),
                              child: Text(
                                '${document['message']}',
                                style: TextStyle(
                                  // Add a little line spacing to make the text look nicer
                                  // when multilined.
                                  height: 1.3,
                                  color: isMe ? Colors.black87 : Colors.white,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Text('error');*/