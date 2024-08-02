import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/const/firebase_data.dart';
import 'package:simple_chat_app/controllers/home_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatsController extends GetxController {
  // variables for chat
  dynamic chatId;
  var chats = FirebaseFirestore.instance.collection('roomId');
  var userId = currentUser!.uid;
  // now as we are passing the arguments we can get them
  var friendId = Get.arguments[1];
  // var friendId = '';
  // it will get the name from the prefs 0 index..
  var username = HomeController.instance.prefs.getStringList('userDetails')![0];
  // get through argument
  var friendname = Get.arguments[0];
  // var friendname = 'Demo friends';

  // text controller
  var messageController = TextEditingController();
  var isloading = false.obs;

  // creatung chatroom
  getChatId() async {
    // it will see if there is a chatroom already created between the 2 users..
    isloading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, userId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            // if chateoom is alredy created then assign the id to our chatId variable...
            chatId = snapshot.docs.single.id;
          } else {
            // if no room is created then create one
            chats.add({
              'users': {userId: null, friendId: null},
              'friend_name': friendname,
              'user_name': username,
              'toId': '',
              'fromId': '',
              "created_on": null,
              'last_msg': '',
            }).then((value) {
              // ?assign the doc id to our chatid variable
              {
                chatId = value.id;
              }
              //lets created a chatroom
              // i am currently using Amit kumar id
              //  so i going to create a room with baaba
              //   you can see there is not chat collection created yet..
            });
          }
        });
    //  when id us obtained make isloading false again
    isloading(false);
  }

  // send message method..
  sendmessage(String msg) {
    if (msg.trim().isNotEmptyAndNotNull) {
      // if msg is not empty or null
      // first update the chat id doc and then save the message to database...

      chats.doc(chatId).update({
        // here er are going to post server time stamp
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': userId,
      });
      //  now save the msg in database
      //  here we are creating another collection named message
      chats.doc(chatId).collection('message').doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        // uid is user to identify who send the msg..
        'uid': userId,
      }).then((value) {
        // after msg is send adn saves clear the textfield..
        messageController.clear();
      });
    }
  }

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }
}
