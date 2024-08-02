import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_chat_app/const/firebase_data.dart';

class HomeController extends GetxController {
  // we'll initialize it later
  late SharedPreferences prefs;
  // creating a variable to access home controller variables on other contrillers..
  static HomeController instance = Get.find();
  String username = '';
  String userImage = '';

  // get user details method
  getUsersDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) async {
      username = value.docs[0]['username'];
      userImage = value.docs[0]['userImage'];
      prefs = await SharedPreferences.getInstance();
      prefs.setStringList('userDetails', [
        // store name and image url on index 0 and 1
        value.docs[0]['username'],
        // value.docs[0]['userImage'],  
      ]);
    });
  }

  // execute this method on start
  @override
  void onInit() {
    getUsersDetails();
    super.onInit();
  }
}
