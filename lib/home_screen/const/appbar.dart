import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/const/firebase_data.dart';
import 'package:simple_chat_app/store_service/store_service.dart';

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
              if (snapshot.hasData) {
                var data = snapshot.data!.docs[0];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: CircleAvatar(
                      child: snapshot != null
                          ? Image.network(
                              data['userImage'],
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(),
                );
              }
            })
      ],
    ),
  );
}
