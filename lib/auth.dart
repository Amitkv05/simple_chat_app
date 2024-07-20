import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_chat_app/widget/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

final _form = GlobalKey<FormState>();

class _AuthenticationState extends State<Authentication> {
  var _isLogin = true;
  var _isSignup = true;
  var _enteredEmail = '';
  var _enteredUsername = '';
  var _enteredPassword = '';
  var _isAuthentication = false;
  File? selectedImage;

  void _submit() async {
    final _isValid = _form.currentState!.validate();
    if (!_isValid) {
      return;
    }
    if (!_isLogin) {
      return;
    }
    try {
      setState(() {
        _isAuthentication = true;
      });
      _form.currentState!.save();
      if (_isSignup) {
        final userLogin = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPassword);
        final storeImage = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${userCredentials.user!.uid}.jpg');
        await storeImage.putFile(selectedImage!);
        final imageUrl = await storeImage.getDownloadURL();
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'id': userCredentials.user!.uid,
          'email': _enteredEmail,
          'username': _enteredUsername,
          'userImage': imageUrl,
          'about': '',
        });
      }
    } on PlatformException catch (error) {
      if (error.code == 'email-already-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication Failed..'),
        ),
      );
      setState(() {
        _isAuthentication = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: Image.asset(
                    'assets/images/bubble-chat.png',
                    height: 230,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  // color: Colors.grey[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _form,
                      child: Column(
                        children: [
                          if (!_isSignup)
                            UserImagePicker(
                              onPickImage: (pickedImage) {
                                selectedImage = pickedImage;
                              },
                            ),
                          // Email.....
                          TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please Enter Valid Email Address';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Email Address',
                            ),
                            onSaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                          ),
                          if (!_isSignup) const SizedBox(height: 6),
                          // Username....
                          if (!_isSignup)
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Your Username';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: 'Username',
                              ),
                              onSaved: (newValue) {
                                _enteredUsername = newValue!;
                              },
                            ),
                          const SizedBox(height: 6),
                          // Password.....
                          TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 4) {
                                return "Password must contain 4 character atleast";
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                            ),
                            onSaved: (newValue) {
                              _enteredPassword = newValue!;
                            },
                          ),
                          const SizedBox(height: 15),
                          if (_isAuthentication)
                            const CircularProgressIndicator(),
                          if (!_isAuthentication)
                            ElevatedButton(
                              onPressed: _submit,
                              child: _isSignup
                                  ? const Text('Login')
                                  : const Text('SignUp'),
                            ),
                          // const SizedBox(height: 10),
                          if (!_isAuthentication)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isSignup = !_isSignup;
                                });
                              },
                              child: _isSignup
                                  ? const Text('Create a new account')
                                  : const Text('I already have Account'),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
