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

  void animacja() {
    setState(() {
      _turns += 1 / 6;
    });
  }

  bool buttonClicked = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    bool _isLoggedWithGoogle =
        Provider.of<GoogleSignInProvider>(context).loggedWithGoogle;

    return Scaffold(
      floatingActionButton: AnimatedRotation(
        duration: const Duration(milliseconds: 500),
        turns: _turns,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () async {
            if (!buttonClicked) {
              buttonClicked = true;
            }
            animacja();
            await Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FriendsPageEditable()));
            });
            buttonClicked = !buttonClicked;
          },
          child: const Icon(
            Icons.settings,
            size: 40,
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
                //     child: _isLoggedWithGoogle
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
                      //   _isLoggedWithGoogle ? user.displayName! : "user",
                      //   softWrap: true,
                      //   maxLines: 2,
                      //   textAlign: TextAlign.center,
                      //   style: GoogleFonts.overpass(
                      //       fontSize: 35, fontWeight: FontWeight.w900),
                      // ),
                      Text(user.email!,
                          maxLines: 4,
                          style: GoogleFonts.overpass(
                              fontSize: 17, fontWeight: FontWeight.w200))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
