import 'package:firebase_auth/firebase_auth.dart';
import 'package:flany/friendspageeditable.dart';
import 'package:flany/providers/googlesignin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  double _turns = 0;

  bool buttonClicked = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    // final _uLoggedWithGoogle =
    //     Provider.of<GoogleSignInProvider>(context).isLoggedWithGoogle;

    return Scaffold(
      floatingActionButton: AnimatedRotation(
        duration: const Duration(milliseconds: 500),
        turns: _turns,
        child: Builder(
          builder: (context) => FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              if (!buttonClicked) {
                buttonClicked = true;
              }
              setState(() {
                _turns += 1 / 6;
              });

              buttonClicked = !buttonClicked;

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FriendsPageEditable()));
            },
            child: const Icon(
              Icons.settings,
              size: 40,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // CircleAvatar(
                //     radius: 72,
                //     child: _uLoggedWithGoogle()
                //         ? CircleAvatar(
                //             radius: 70,
                //             backgroundImage: NetworkImage(user.photoURL!),
                //           )
                //         : const CircleAvatar(
                //             radius: 70,
                //             backgroundImage: AssetImage("images/user.png"),
                //           )),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      // Text(
                      //   _uLoggedWithGoogle()
                      //       ? user.displayName!
                      //       : Provider.of<GoogleSignInProvider>(context)
                      //           .nameCont
                      //           .text,
                      //   softWrap: true,
                      //   maxLines: 2,
                      //   textAlign: TextAlign.center,
                      //   style: GoogleFonts.overpass(
                      //       fontSize: 35, fontWeight: FontWeight.w900),
                      // ),
                      Text(user.email!,
                          maxLines: 4,
                          style: GoogleFonts.overpass(
                              fontSize: 17, fontWeight: FontWeight.w200)),
                      Text(user.providerData.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);

                provider.logout();
              },
              child: const Text("log out")),
        ],
      ),
    );
  }
}
