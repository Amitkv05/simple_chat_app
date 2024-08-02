import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/Services/store_service.dart';
import 'package:simple_chat_app/const/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'New message',
          style: TextStyle(color: Colors.white, fontFamily: 'mont_semi'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          color: Colors.white,
        ),
        child: StreamBuilder(
          stream: StoreService.getAllUser(),
          // builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(bgColor),
                ),
              );
            } else {
              return GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                // here we are coverting our snapshot into a map for easy access to all the docs..
                children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                  // settings our each  doc into a variable for easy access..
                  var doc = snapshot.data!.docs[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 18.0),
                                child: ClipOval(
                                  child: CircleAvatar(
                                    radius: 32,
                                    // backgroundImage: NetworkImage('${doc['image_url']}'),
                                    // backgroundImage:
                                    //     AssetImage('assets/icons/ic_user.png'),
                                    child: Image.network(
                                      doc['userImage'],
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '${doc['username']}',
                                style: const TextStyle(
                                  fontFamily: 'mont_semi',
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          ElevatedButton.icon(
                              onPressed: () {
                                // on top of this button we are going to send our user to the chat screen
                                // but we want to change the name of the user
                                // Get.to(
                                //     () => ChatScreen(
                                //         // user: '${doc['name']}',
                                //         ),
                                //     transition: Transition.downToUp,
                                //     arguments: [
                                //       // but here in compose chat screen we have implemented everything so lets add
                                //       // real values
                                //       doc['name'],
                                //       doc['id'],
                                //     ]);
                              },
                              icon: const Icon(Icons.message),
                              label: const Text('Message'))
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }
            // we are using grid view here..
          },
        ),
      ),
    );
  }
}
