import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/Services/chat_service.dart';
import 'package:simple_chat_app/Services/store_service.dart';
import 'package:simple_chat_app/chat_screen/msg_screen.dart';
import 'package:simple_chat_app/const/firebase_data.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatsComponent extends StatelessWidget {
  const ChatsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: StoreService.getAllUser(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return Stack(
              children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                // var sender = FirebaseFirestore.instance
                //     .collection('users')
                //     .doc(currentUser)
                //     .snapshots();
                final loadedMessage = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: loadedMessage.length,
                    itemBuilder: (context, index) {
                      final data = loadedMessage[index];
                      return Card(
                        color: Colors.yellow,
                        child: ListTile(
                          onTap: () {
                            Get.to(() => MsgScreen(
                                  // sendername: StoreService.getUser('username'),
                                  sendername: data['username'],
                                  receiverUserEmail: data['email'],
                                  receiverUserId: data['id'],
                                  receivername: data['username'],
                                  receiverImage: data['userImage'],
                                ));
                          },
                          leading: ClipOval(
                            child: CircleAvatar(
                              child: Image.network(
                                data['userImage'],
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(data['username']),
                          subtitle: const Text('last msg'),
                          trailing: const Text('2:00 Am'),
                        ),
                      );
                    });
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
