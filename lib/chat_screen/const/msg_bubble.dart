import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/Services/store_service.dart';
import 'package:simple_chat_app/const/firebase_data.dart';
import 'package:intl/intl.dart' as intl;

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
    var t = document['timestamp'] == null
        ? DateTime.now()
        : document['timestamp'].toDate();
    var time = intl.DateFormat("h:mma").format(t);
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Directionality(
      // Lets fix who send the message..
      textDirection: document['senderId'] == currentUser!.uid
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: FutureBuilder(
          future: StoreService.getUser(user!.uid),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            final isMe = document['senderId'] == currentUser!.uid;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
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
                      const SizedBox(width: 40),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (document['senderId'] != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 13,
                                right: 13,
                              ),
                              child: document['senderId'] == currentUser!.uid
                                  ? Text(
                                      CurrentUserdata['username'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(receivername,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                            ),
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
                        ],
                      ),
                      const SizedBox(width: 20),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          // time,
                          time,
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
            // }
            // return Container();
          }),
      // ),
    );
  }
}
