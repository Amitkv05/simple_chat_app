import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/const/firebase_data.dart';
import 'package:simple_chat_app/store_service/store_service.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var usernameController = TextEditingController();
  var aboutController = TextEditingController();
  var emailIdController = TextEditingController();
  var pickedImage = '';

  @override
  void initState() {
    TextEditingController().dispose();
    super.initState();
  }

  // final user = FirebaseAuth.instance.currentUser!;
  void updateProfile() async {
    var store = FirebaseFirestore.instance.collection('users').doc(user!.uid);
    await store.set({
      'username': usernameController.text,
      'about': aboutController.text,
      'email': emailIdController.text,
      'userImage': pickedImage,
    }, SetOptions(merge: true));
    VxToast.show(context, msg: 'Profile updated successfully....');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Profile'),
        actions: [
          TextButton(onPressed: updateProfile, child: const Text('Save'))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            FutureBuilder(
                future: StoreService.getUser(user!.uid),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.docs[0];
                    usernameController.text = data['username'];
                    aboutController.text = data['about'];
                    emailIdController.text = data['email'];
                    return Column(
                      children: [
                        Stack(
                          children: [
                            ClipOval(
                              child: CircleAvatar(
                                radius: 76,
                                child: Image.network(
                                  data['userImage'],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 8,
                                right: 0,
                                child: CircleAvatar(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.photo_camera_rounded)),
                                ))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: Colors.grey[800],
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          title: TextFormField(
                            controller: usernameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                label: Text('Username'),
                                labelStyle: TextStyle(color: Colors.white),
                                isDense: true,
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          title: TextFormField(
                            controller: aboutController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                label: Text('About'),
                                labelStyle: TextStyle(color: Colors.white),
                                isDense: true,
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          title: TextFormField(
                            controller: emailIdController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                label: Text('Email Address'),
                                labelStyle: TextStyle(color: Colors.white),
                                isDense: true,
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
