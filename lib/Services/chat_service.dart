import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_app/Services/store_service.dart';
import 'package:simple_chat_app/const/firebase_data.dart';
import 'package:simple_chat_app/models/message.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore..
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // send Message...
  Future<void> sendMessage(String receiverId, String message) async {
    // get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    // final String currentUserUsername = FirebaseFirestore.instance.collection('users').get('username');
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    // create a new Message..
    Message newMessage = Message(
        senderId: currentUserId,
        // senderUsername: currentUserUsername!,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);
    // construct chat room id from current user id and receiver id (sorted ti ensure uniqueness)..
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort the ids(this ensure the chat room id is always the same for any pair of people)..
    String chatRoomId = ids.join(
        '_'); //combine the ids into a single string to use as a chatroomId...

    // add new message to database..
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

// Get Message...
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // construct chat room id from user ids(sorted to ensure it matches the id used when sending messages)...
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
