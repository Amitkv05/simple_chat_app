import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_chat_app/const/firebase_data.dart';
import 'package:simple_chat_app/models/message.dart';

class StoreService {
// get user data
  static getUser(String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .get();
  }

  // Stream<List<Map<String, dynamic>>> getUserStream() {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       // go tthrough each individual user..
  //       final user = doc.data();
  //       // return user
  //       return user;
  //     }).toList();
  //   });
  // }

  // get all user from our firebase users collection
  static getAllUser() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

//   static getChats(String chatId) {
//     // it will get all the messages from
//     // chats collection -> chat id doc -> messages collection..
//     // here set  orderby created_on amd decending....
//     return FirebaseFirestore.instance
//         .collection('roomId')
//         .doc(chatId)
//         .collection('message')
//         .orderBy('created_on', descending: false)
//         .snapshots();
//   }

//   // get all messages
//   static getMessages() {
//     // get all messages from chats collection where users list include current user.
//     // and created_on is not equal to null means there should be atleast a message..

//     return FirebaseFirestore.instance
//         .collection('roomId')
//         .where('users.${currentUser!.uid}', isEqualTo: null)
//         .where('created_on', isNotEqualTo: null)
//         .snapshots();
//   }
//   //   static getUsersDetails() async {
//   //   late SharedPreferences prefs;
//   //   await FirebaseFirestore.instance
//   //       .collection('users')
//   //       .where('id', isEqualTo: currentUser!.uid)
//   //       .get()
//   //       .then((value) async {
//   //     // here we are getting our current user details stored in the value variable.
//   //     prefs = await SharedPreferences.getInstance();
//   //     prefs.setStringList('user_details', [
//   //       // store name and image url on index 0 and 1
//   //       value.docs[0]['name'],
//   //       value.docs[0]['userImage'],
//   //     ]);
//   //   });
//   // }

//   // static getAllMessages() async {
//   //   return await FirebaseFirestore.instance.collection('chat').add({
//   //     'text': enteredMessage,
//   //     'createdAt': Timestamp.now(),
//   //     'userId': user.uid,
//   //     'username': getUser.data()!['username'],
//   //     'userImage': userData.data()!['userImage'],
//   //   }
//   // );
//   // }

//   // send message.....
//   // Future<void> sendMessage(String receiverId, message) async {
//   //   // get current user info...
//   //   // final String currentUserId = getUser(user!.uid);
//   //   // final String currentUserEmail = getUser(user!.uid)['email'];
//   //   final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//   //   final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
//   //   final Timestamp timestamp = Timestamp.now();

//   //   // create a new message....
//   //   Message newMessage = Message(
//   //     senderId: currentUserId,
//   //     senderEmail: currentUserEmail,
//   //     receiverId: receiverId,
//   //     message: message,
//   //     timestamp: timestamp,
//   //   );

//   // construct chat room Id for the two users(sorted to ensure uniquenesss....).

//   //   List<String> roomiID = [currentUserId, receiverId];
//   //   roomiID
//   //       .sort(); // sort the roomId (This ensure the chatroomID is the same for any 2 people)..
//   //   String chatRoomId = roomiID.join('_');

//   //   // add new message to database
//   //   await FirebaseFirestore.instance
//   //       .collection('chat_rooms')
//   //       .doc(chatRoomId)
//   //       .collection('messages')
//   //       .add(newMessage.toMap());
//   // }

// //   // get message...
//   // Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
//   //   // construct a chatroom Id for the two users...
//   //   List<String> ids = [userId, otherUserId];
//   //   ids.sort();
//   //   String chatRoomId = ids.join('_');

//   //   return FirebaseFirestore.instance
//   //       .collection('chat_rooms')
//   //       .doc(chatRoomId)
//   //       .collection('messages')
//   //       .orderBy('timestamp', descending: false)
//   //       .snapshots();
//   // }

//   // for getting all messages of a specific conversation from firestore database...

//   // static Stream<QuerySnapshot<Map<String, dynamic>>> getUsersDetails() async{

//   //  execute this method on start..
//   // @override
//   // void onInit() {
//   //   getUsersDetails();
//   //   super.onInit();
  // }
}
