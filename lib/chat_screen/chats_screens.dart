import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/chat_screen/msg_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatsScreens extends StatelessWidget {
  const ChatsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Get.to(() => const MessageScreen());
            },
            leading: const CircleAvatar(),
            title: const Text("Username"),
            subtitle: const Text('last message....'),
            trailing: const Text('2:00 Am'),
          );
        },
      ),
    );
  }
}
