import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flany/providers/googlesignin.dart';
import 'package:flany/widgets/classes/inputwindows.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/////////// ZMIENNE OGÓLNE ///////////////
bool _isLoginClicked = true;
bool isTextObscured = true;
////////// KONIEC ZMIENNYCH OGÓLNYCH /////
final TextEditingController nameCont = TextEditingController();
final TextEditingController mailCont = TextEditingController();
final TextEditingController passCont = TextEditingController();
Future signInWithEmail() async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: mailCont.text.trim(), password: passCont.text.trim());
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          curve: Curves.linearToEaseOut,
          duration: const Duration(milliseconds: 300),
          height: _isKeyboard ? 0 : 150,
          child: const Image(
            height: 150,
            fit: BoxFit.scaleDown,
            image: AssetImage('images/flunny_2_better.png'),
          ),
        ),
        if (!_isLoginClicked) const SizedBox(height: 15),
        AnimatedContainer(
          curve: Curves.linearToEaseOut,
          duration: const Duration(milliseconds: 400),
          width: _isLoginClicked ? 0 : MediaQuery.of(context).size.width,
          height: _isLoginClicked ? 0 : 60,
          child: Visibility(
            visible: !_isLoginClicked,
            child: LoginInput(
              myController: nameCont,
              myHintText: 'Użytkownik',
              myPrefixIcon: const Icon(Icons.person),
              myKeyboardType: TextInputType.name,
            ),
          ),
        ),
        const SizedBox(height: 15),
        LoginInput(
          myController: mailCont,
          myHintText: 'Email',
          myPrefixIcon: const Icon(Icons.email),
          myKeyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 15),
        LoginInput(
            isTextObscured: isTextObscured,
            mySuffIcon: AnimatedIconButton(
              size: 24,
              animationDirection: const AnimationDirection.bounce(),
              onPressed: () async {
                await Future.delayed(const Duration(milliseconds: 400), () {
                  setState(() {
                    isTextObscured = !isTextObscured;
                  });
                });
              },
              duration: const Duration(milliseconds: 400),
              splashColor: Colors.transparent,
              icons: const <AnimatedIconItem>[
                AnimatedIconItem(icon: Icon(Icons.remove_red_eye_outlined)),
                AnimatedIconItem(icon: Icon(Icons.remove_red_eye)),
              ],
            ),
            myController: passCont,
            myHintText: 'Hasło',
            myPrefixIcon: const Icon(Icons.key_rounded),
            myKeyboardType: TextInputType.visiblePassword),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(30))),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15)),
                onPressed: () {
                  signInWithEmail();
                  setState(() {
                    _isLoginClicked = true;
                  });
                },
                child: _isLoginClicked
                    ? GradientText(
                        'Zaloguj',
                        style: const TextStyle(fontSize: 21),
                        colors: const [
                          Color.fromARGB(255, 120, 239, 255),
                          Color.fromARGB(255, 98, 255, 156)
                        ],
                      )
                    : Text(
                        "Zaloguj",
                        style: GoogleFonts.overpass(fontSize: 20),
                      )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(30))),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15)),
                onPressed: () {
                  setState(() {
                    _isLoginClicked = false;
                  });
                },
                child: _isLoginClicked
                    ? Text(
                        "Zarejestruj",
                        style: GoogleFonts.overpass(fontSize: 20),
                      )
                    : GradientText(
                        'Zarejestruj',
                        style: const TextStyle(fontSize: 21),
                        colors: const [
                          Color.fromARGB(255, 120, 239, 255),
                          Color.fromARGB(255, 98, 255, 156)
                        ],
                      )),
          ],
        ),
        Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                icon: const FaIcon(FontAwesomeIcons.google),
                label: const Text("Zarejestruj się przez"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(30, 10, 35, 10),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(50))),
                ),
              ),
            ),
          ],
        )
      ],
    );

  }
}
