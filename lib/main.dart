import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flany/options.dart';
import 'package:flany/providers/googlesignin.dart';
import 'package:flany/widgets/classes/inputwindows.dart';
import 'package:flany/providers/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

/////////// ZMIENNE OGÓLNE ///////////////
bool _isLoginClicked = true;
double _myOpacity = 0;
bool isTextObscured = true;
////////// KONIEC ZMIENNYCH OGÓLNYCH /////

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (_) => ThemesProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
//This theme should have a [ThemeData.brightness] set to [Brightness.dark].
//Uses [theme] instead when null. Defaults to the value of [ThemeData.light()]
//when both [darkTheme] and [theme] are null.

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: Provider.of<ThemesProvider>(context).darkModeOn
            ? ThemeOptions.white
            : ThemeOptions.black,
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController mailCont = TextEditingController();
  final TextEditingController passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("F L A N K I", style: GoogleFonts.aBeeZee(fontSize: 50.0)),
      ),
      body: Column(
        children: [
          // if (!_isKeyboard)
          const SizedBox(height: 20),
          const Expanded(
            child: Image(
              image: AssetImage('images/flunny_2_better.png'),
            ),
          ),

          Expanded(
            flex: 4,
            child: Column(
              children: [
                Column(
                  children: [
                    if (!_isLoginClicked) const SizedBox(height: 15),
                    AnimatedContainer(
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(milliseconds: 400),
                      width: _isLoginClicked
                          ? 0
                          : MediaQuery.of(context).size.width,
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
                            await Future.delayed(
                                const Duration(milliseconds: 400), () {
                              setState(() {
                                isTextObscured = !isTextObscured;
                              });
                            });
                          },
                          duration: const Duration(milliseconds: 400),
                          splashColor: Colors.transparent,
                          icons: const <AnimatedIconItem>[
                            AnimatedIconItem(
                                icon: Icon(Icons.remove_red_eye_outlined)),
                            AnimatedIconItem(icon: Icon(Icons.remove_red_eye)),
                          ],
                        ),
                        myController: passCont,
                        myHintText: 'Hasło',
                        myPrefixIcon: const Icon(Icons.key_rounded),
                        myKeyboardType: TextInputType.visiblePassword),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(30))),
                            foregroundColor: (_isLoginClicked)
                                ? Colors.black
                                : const Color.fromARGB(255, 173, 173, 173),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15)),
                        onPressed: () {
                          setState(() {
                            if (_isLoginClicked == false) {
                              _isLoginClicked = true;
                            } else {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) =>
                              //             const GoogleOptions())));
                            }
                          });
                        },
                        child: Text("Zaloguj",
                            style: GoogleFonts.overpass(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(30))),
                            foregroundColor: (_isLoginClicked)
                                ? const Color.fromARGB(255, 173, 173, 173)
                                : Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15)),
                        onPressed: () {
                          setState(() {
                            if (_isLoginClicked) {
                              _isLoginClicked = false;
                              _myOpacity = 1;
                            } else {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) =>
                              //             const GoogleOptions())));
                            }
                          });
                        },
                        child: Text("Zarejestruj",
                            style: GoogleFonts.overpass(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ],
                ),
                Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const GoogleOptions())));
                        },
                        icon: const FaIcon(FontAwesomeIcons.google),
                        label: const Text("Zarejestruj się przez"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(30, 10, 35, 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(50))),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
