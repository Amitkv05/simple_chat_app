import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/Services/store_service.dart';
import 'package:simple_chat_app/chat_screen/chats_screens.dart';
import 'package:velocity_x/velocity_x.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('New Message'),
      ),
      // we are using stream builder here for realtime changes...
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          // color: Colors.red,
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: StreamBuilder(
          stream: StoreService.getAllUser(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                // here we are converting our snapshot into a map for easy access to all the docs....
                children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                  // setting our each doc into a variables for easy access..
                  var docData = snapshot.data!.docs[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    // height: 150,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 6),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 18),
                                  child: ClipOval(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 32,
                                      child: snapshot != null
                                          ? Image.network(
                                              docData['userImage'],
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.cover,
                                            )
                                          : const CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                    ),
                                  ),
                                ),
                                Text(
                                  // 'username',
                                  '${docData['username']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => ChatsScreens(),
                                    transition: Transition.downToUp);
                              },
                              child: const Text('Message'),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
