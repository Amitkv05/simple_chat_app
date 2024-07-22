import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoreService {
// get user data
  static getUser(String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .get();
  }

  // get all user from our firebase users collection
  static getAllUser() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }
}
