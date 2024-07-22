import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/const/firebase_data.dart';
import 'package:simple_chat_app/Services/store_service.dart';
import 'package:velocity_x/velocity_x.dart';

Widget Appbar(GlobalKey<ScaffoldState> key) {
  return Container(
    height: 65,
    color: Colors.black,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            height: 70,
            width: 75,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: IconButton(
              onPressed: () {
                key.currentState!.openDrawer();
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            )),
        RichText(
          text: TextSpan(children: [
            const TextSpan(
              text: 'Simple Chat\n',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '                   connecting lives.....',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ]),
        ),
        FutureBuilder(
            future: StoreService.getUser(user!.uid),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                // var index = 0;
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              } else {
                return Stack(
                  children:
                      snapshot.data!.docs.mapIndexed((currentValue, index) {
                    var appData = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipOval(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: snapshot != null
                              ? Image.network(
                                  appData['userImage'],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            }),
      ],
    ),
  );
}
