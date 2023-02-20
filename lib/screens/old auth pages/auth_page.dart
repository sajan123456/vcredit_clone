import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:vcredit_copy/provider/auth_provider.dart';
import 'package:vcredit_copy/provider/image_provider.dart';
import 'package:vcredit_copy/provider/toggle_provider.dart';
import 'package:vcredit_copy/screens/homepage.dart';

final _form = GlobalKey<FormState>();
final nameController = TextEditingController();
final mailController = TextEditingController();
final passController = TextEditingController();

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Consumer(
        builder: (context, ref, child) {
          final loginCheck = ref.watch(loginProvider);
          final imageData = ref.watch(imageProvider);
          return Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _form,
                child: ListView(children: [
                  Text(
                    loginCheck ? 'Login Page' : 'Registration Page',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //image pick
                  if (loginCheck == false)
                    InkWell(
                      onTap: () {
                        ref.read(imageProvider.notifier).imageSelect();
                      },
                      child: Container(
                          height: 100,
                          child: imageData == null
                              ? Text('Select an image')
                              : Image.file(File(imageData.path))),
                    ),

                  if (loginCheck == false)
                    //username
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'Please provide username';
                        } else if (value.length > 15) {
                          return 'Maximum character exceeded';
                        }
                        return null;
                      }),
                      controller: nameController,
                      decoration: InputDecoration(hintText: 'Name'),
                    ),
                  //email
                  TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Please provide email';
                      } else if (!value.contains('@')) {
                        return 'Bad Email format';
                      }
                      return null;
                    }),
                    controller: mailController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  //password
                  TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Please provide password';
                      } else if (value.length > 15) {
                        return 'Maximum character exceeded';
                      }
                      return null;
                    }),
                    obscureText: true,
                    controller: passController,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            _form.currentState!.save();
                            if (_form.currentState!.validate()) {
                              if (loginCheck == true) {
                                final response = await ref
                                    .read(authProvider)
                                    .userLogin(
                                        email: mailController.text
                                            .replaceAll(RegExp(r"\s+"), ""),
                                        password: passController.text.trim());
                                if (response != 'success') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration:
                                              Duration(milliseconds: 1500),
                                          content: Text(
                                              'No User Found, Please Register')));
                                }
                              } else {
                                if (imageData == null) {
                                  Get.defaultDialog(
                                      title: 'Image required',
                                      content: Text(
                                        'Please select an image',
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text('Ok'))
                                      ]);
                                } else {
                                  final response = await ref
                                      .read(authProvider)
                                      .userSignUp(
                                          image: imageData,
                                          username: nameController.text.trim(),
                                          email: mailController.text
                                              .replaceAll(RegExp(r"\s+"), ""),
                                          password: passController.text.trim());
                                  // if (response != 'success') {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //       SnackBar(
                                  //           duration:
                                  //               Duration(milliseconds: 1500),
                                  //           content: Text(response)));
                                  // }
                                }
                              }

                              // Get.to(HomePage());
                            }
                          },
                          child: Text(loginCheck ? 'Login' : 'Register')),
                      Row(
                        children: [
                          Text(loginCheck
                              ? 'No account yet? '
                              : 'Already have an account?'),
                          TextButton(
                            onPressed: () {
                              ref.read(loginProvider.notifier).toggle();
                            },
                            child: Text(loginCheck ? 'Register here' : 'Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ));
        },
      ),
    );
  }
}
