import 'package:firebase_auth/firebase_auth.dart';
import 'package:flany/friendspage.dart';
import 'package:flany/main.dart';
import 'package:flutter/material.dart';

class GoogleOptions extends StatelessWidget {
  const GoogleOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const FriendsPage();
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something is Wrong.."));
            } else {
              return const MyHomePage();
            }
          }),
    );
  }
}
