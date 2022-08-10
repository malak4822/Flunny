import 'package:firebase_auth/firebase_auth.dart';
import 'package:flany/friendspage.dart';
import 'package:flany/friendspageeditable.dart';
import 'package:flany/main.dart';
import 'package:flany/providers/googlesignin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleOptions extends StatelessWidget {
  const GoogleOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isLoggedonGoogle = Provider.of<GoogleSignInProvider>(context).loggedWithGoogle;
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              _isLoggedonGoogle = true;
              return const FriendsPageEditable();
            } else if (snapshot.hasError) {
              _isLoggedonGoogle = false;
              return const Center(child: Text("Something is Wrong.."));
            } else {
              _isLoggedonGoogle = false;
              return const MyHomePage();
            }
          }),
    );
  }
}
