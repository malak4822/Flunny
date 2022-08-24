import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
// LOGOWANIE PRZEZ EMAIL I HASŁO LOGOWANIE PRZEZ EMAIL I HASŁO

  bool isLoggedWithGoogle() {
    var provUser = FirebaseAuth.instance.currentUser;
    if (provUser?.providerData[0].providerId == "google.com") {
      return true;
    } else {
      return false;
    }
  }

  final TextEditingController nameCont = TextEditingController();

// LOGOWANIE PRZEZ EMAIL I HASŁO LOGOWANIE PRZEZ EMAIL I HASŁO

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future logout() async {
    var provUser = FirebaseAuth.instance.currentUser;
    if (provUser!.providerData[0].providerId == "google.com") {
      await googleSignIn.disconnect();
    }
    FirebaseAuth.instance.signOut();
  }
}
