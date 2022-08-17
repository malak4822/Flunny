import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flany/providers/googlesignin.dart';
import 'package:flany/providers/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendsPageEditable extends StatefulWidget {
  const FriendsPageEditable({Key? key}) : super(key: key);

  @override
  _FriendsPageEditableState createState() => _FriendsPageEditableState();
}

class _FriendsPageEditableState extends State<FriendsPageEditable> {
  @override
  Widget build(BuildContext context) {
    // final _uLoggedWithGoogle =
    //     Provider.of<GoogleSignInProvider>(context).isLoggedWithGoogle;

    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              //   GestureDetector(
              //     onTap: () {
              //       showModalBottomSheet(
              //           shape: const RoundedRectangleBorder(
              //               borderRadius: BorderRadius.vertical(
              //                   top: Radius.circular(80))),
              //           context: context,
              //           builder: ((builder) => bottomLine()));
              //     },
              //     // child: CircleAvatar(
              //     //     radius: 72,
              //     //     child: _uLoggedWithGoogle()
              //     //         ? CircleAvatar(
              //     //             radius: 70,
              //     //             backgroundImage: NetworkImage(user.photoURL!),
              //     //             child: imgShadow(),
              //     //           )
              //     //         : CircleAvatar(
              //     //             radius: 70,
              //     //             backgroundImage:
              //     //                 const AssetImage("images/user.png"),
              //     //             child: imgShadow(),
              //     //           )),
              //  ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Text(
                          //     _uLoggedWithGoogle() ? user.displayName! : "user",
                          //     maxLines: 2,
                          //     style: GoogleFonts.overpass(
                          //       fontSize: 30,
                          //       fontWeight: FontWeight.w900,
                          //     )),
                          blackie(30),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(user.email!,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.overpass(
                                fontSize: 16,
                                fontWeight: FontWeight.w200,
                              )),
                          blackie(10),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          AnimatedIconButton(
            size: 44,
            animationDirection: const AnimationDirection.bounce(),
            onPressed: () {
              setState(() {
                Provider.of<ThemesProvider>(context, listen: false)
                    .darkModeChanger();
              });
            },
            duration: const Duration(milliseconds: 400),
            splashColor: Colors.transparent,
            icons: const <AnimatedIconItem>[
              AnimatedIconItem(
                  icon: Icon(
                Icons.wb_sunny_rounded,
              )),
              AnimatedIconItem(
                  icon: Icon(
                Icons.nights_stay_rounded,
                color: Colors.black,
              )),
            ],
          ),
    
        ],
      ),
    );
  }

  Widget bottomLine() {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_a_photo_rounded,
                size: 50,
              ),
              Text(
                "Add Photo",
                style: GoogleFonts.overpass(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                (Icons.camera),
                size: 50,
              ),
              Text("Make Photo",
                  style: GoogleFonts.overpass(
                      fontSize: 20, fontWeight: FontWeight.bold))
            ],
          ))
        ],
      ),
    );
  }

  Widget imgShadow() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.black.withOpacity(0.6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.photo,
            size: 50,
          ),
          Text("Upload Image",
              style: GoogleFonts.overpass(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

Widget blackie(double myPadding) {
  return Container(
    padding: EdgeInsets.all(myPadding),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.6),
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Center(
      child: Icon(
        Icons.border_color,
        size: 35,
        color: Colors.white,
      ),
    ),
  );
}
