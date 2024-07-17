import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget imagePicker(context) {
  void pickImage() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 180,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              // width: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "Selected Sources",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: const Row(
                          children: [
                            Icon(Icons.camera_alt_outlined),
                            SizedBox(width: 10),
                            Text('Camera',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.photo),
                          SizedBox(width: 10),
                          Text('Gallery',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.cancel),
                          SizedBox(width: 10),
                          Text('Cancel',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  return Column(
    children: [
      const CircleAvatar(
        radius: 32,
      ),
      TextButton.icon(
        onPressed: pickImage,
        icon: const Icon(
          Icons.camera_alt_outlined,
          size: 18,
        ),
        label: const Text('Add Image'),
      )
    ],
  );
}
