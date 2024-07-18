import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_chat_app/const/firebase_data.dart';
import 'package:simple_chat_app/home_screen/const/appbar.dart';
import 'package:simple_chat_app/home_screen/const/drawer.dart';
import 'package:simple_chat_app/store_service/store_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          drawer: drawer(),
          body: Column(
            children: [
              Appbar(scaffoldKey),
              Container(
                child: Placeholder(),
              )
            ],
          )),
    );
  }
}
