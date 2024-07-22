import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simple_chat_app/chat_screen/chats_screens.dart';
import 'package:simple_chat_app/chat_screen/compose_screen.dart';
import 'package:simple_chat_app/home_screen/const/appbar.dart';
import 'package:simple_chat_app/home_screen/const/drawer.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(() => ComposeScreen());
              },
              child: const Icon(Icons.add),
            ),
            backgroundColor: Colors.black,
            key: scaffoldKey,
            drawer: drawer(),
            body: Column(
              children: [
                Appbar(scaffoldKey),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        color: Colors.grey,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: TabBar(
                            labelColor: Colors.white,
                            labelStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            unselectedLabelColor: Colors.grey[600],
                            tabs: const [
                              Tab(text: 'Chats'),
                              Tab(text: 'Status'),
                              Tab(text: 'Camera'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: TabBarView(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                ),
                              ),
                              child: ChatsScreens(),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                  )),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                  )),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
