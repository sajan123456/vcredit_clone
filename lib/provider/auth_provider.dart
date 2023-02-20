import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';

final authStream =
    StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());

final singleUserStream = StreamProvider((ref) => AuthProvider().userStream());

final authProvider = Provider((ref) => AuthProvider());

class AuthProvider {
  final userDb = FirebaseFirestore.instance.collection('users');

  //user sign up
  Future<String> userSignUp(
      {required String username,
      required String email,
      required String password,
      required XFile image}) async {
    try {
      final imageId = DateTime.now().toString();
      final ref = FirebaseStorage.instance.ref().child('userImage/$imageId');
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
            firstName: username,
            id: credential.user!.uid, // UID from Firebase Authentication
            imageUrl: url,
            // lastName: 'Doe',
            metadata: {'email': email}),
      );

      return ' success';
    } on FirebaseAuthException catch (err) {
      return '${err.message}';
    }
  }

//user login
  Future<String> userLogin(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return ' success';
    } on FirebaseAuthException catch (err) {
      return '${err.message}';
    }
  }

//user log out
  Future<String> userLogout() async {
    try {
      final credential = await FirebaseAuth.instance.signOut();

      return ' success';
    } on FirebaseAuthException catch (err) {
      return '${err.message}';
    }
  }

//single user data
  Stream<types.User> userStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      final data = userDb.doc(uid).snapshots().map((event) {
        final json = event.data() as Map<String, dynamic>;
        return types.User(
            id: event.id,
            imageUrl: json['imageUrl'],
            firstName: json['firstName'],
            metadata: {
              'email': json['metadata']['email'],
            });
      });
      return data;
    } on FirebaseAuthException catch (err) {
      throw '${err.message}';
    }
  }
}
