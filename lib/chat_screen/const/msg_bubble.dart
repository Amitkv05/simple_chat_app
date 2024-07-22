import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget msgBubble() {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: CircleAvatar(
              backgroundColor: Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: 80,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0),
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                )),
            child: const Center(child: Text('Hello')),
          ),
        ],
      ),
    ),
  );
}
