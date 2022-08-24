import 'package:firebase_auth/firebase_auth.dart';
import 'package:flany/providers/googlesignin.dart';
import 'package:flany/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  double _turns = 0;

  bool buttonClicked = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    final _uLoggedWithGoogle =
        Provider.of<GoogleSignInProvider>(context).isLoggedWithGoogle;

    return Scaffold(
      floatingActionButton: AnimatedRotation(
        duration: const Duration(milliseconds: 500),
        turns: _turns,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            if (!buttonClicked) {
              buttonClicked = true;
            }
            setState(() {
              _turns += 1 / 6;
            });

            buttonClicked = !buttonClicked;

            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const UserSettingsPage()));
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
                CircleAvatar(
                    radius: 72,
                    child: _uLoggedWithGoogle()
                        ? CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(user.photoURL!),
                          )
                        : const CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage("images/user/user.png"),
                          )),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        _uLoggedWithGoogle()
                            ? user.displayName!
                            : Provider.of<GoogleSignInProvider>(context)
                                .nameCont
                                .text,
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.overpass(
                            fontSize: 35, fontWeight: FontWeight.w900),
                      ),
                      Text(user.email!,
                          maxLines: 4,
                          style: GoogleFonts.overpass(
                              fontSize: 17, fontWeight: FontWeight.w200)),
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
