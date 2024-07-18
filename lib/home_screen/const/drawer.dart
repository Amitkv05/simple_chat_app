import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/const/firebase_data.dart';
import 'package:simple_chat_app/const/icons_data.dart';
import 'package:simple_chat_app/const/string_data.dart';
import 'package:simple_chat_app/home_screen/const/profile_screen.dart';
import 'package:simple_chat_app/store_service/store_service.dart';

Widget drawer() {
  return Container(
    width: 300,
    color: Colors.black,
    child: Column(
      children: [
        ListTile(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder(
            future: StoreService.getUser(user!.uid),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs[0];
                return CircleAvatar(
                  radius: 56,
                  child: ClipOval(
                      child: Image.network(
                    data['userImage'],
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  )),
                );
              } else {
                return const CircleAvatar(
                  radius: 56,
                );
              }
            }),
        const SizedBox(height: 6),
        const Text(
          'Username',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Color.fromARGB(255, 45, 45, 45),
          height: 0.3,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: drawerIconsList.length,
          itemBuilder: (context, index) {
            final drawerIcon = drawerIconsList[index];
            final drawerName = drawerIconsName[index];
            return ListTile(
              onTap: () {
                switch (index) {
                  case 0:
                    Get.to(() => ProfileScreen());
                    break;
                  default:
                }
              },
              leading: Icon(
                drawerIcon,
                color: Colors.white,
              ),
              title:
                  Text(drawerName, style: const TextStyle(color: Colors.white)),
            );
          },
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Color.fromARGB(255, 45, 45, 45),
          height: 0.3,
        ),
        const ListTile(
          leading: Icon(
            Icons.emoji_people_rounded,
            color: Colors.white,
          ),
          title: Text(
            'Invite a Friend',
            style: TextStyle(color: Colors.white),
          ),
        ),
        // ),
        const Spacer(),
        ListTile(
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
          leading: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ),
  );
}
