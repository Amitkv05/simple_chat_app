import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? pickedImage;
  void _getFromCamera() async {
    try {
      final selectedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        pickedImage = File(selectedImage!.path);
      });
      widget.onPickImage(pickedImage!);
      VxToast.show(context, msg: 'Image is selected Successfully');
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  void _getFromGallery() async {
    try {
      final selectedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        pickedImage = File(selectedImage!.path);
      });
      widget.onPickImage(pickedImage!);
      VxToast.show(context, msg: 'Image is selected Successfully');
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  void _pickImage() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 180,
              width: 180,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                          _getFromCamera();
                        },
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
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                          _getFromGallery();
                        },
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
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
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
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: Colors.grey,
          foregroundImage: pickedImage != null ? FileImage(pickedImage!) : null,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.image_rounded),
            label: const Text(
              'Add Image',
              // style: Theme.of(context).textTheme.titleSmall,
            )),
      ],
    );
  }
}
