import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoreService {

  static getUser(String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .get();
  }
}
