import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:vcredit_copy/screens/homepage.dart';
import 'package:vcredit_copy/screens/login_page.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }

  signInWithGoogle() async {
    //trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //create a new credential
    final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }

  signOut() async {
    FirebaseAuth.instance.signOut();
  }

  // Future<Null> signOut() async {
  //   // Sign out with firebase
  //   await FirebaseAuth.instance.signOut();
  //   // Sign out with google
  //   await GoogleSignIn().signOut();
  // }
}
