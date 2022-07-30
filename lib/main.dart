import 'package:flany/googlesignin.dart';
import 'package:flany/options.dart';
import 'package:flany/widgets/classes/inputwindows.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GoogleSignInProvider())],
    child: const MyApp(),
  ));
}

bool _loggedWithGoogle = true;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(

        theme: ThemeData().copyWith(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: Colors.white, secondary: Colors.black),
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatelessWidget {
  final TextEditingController mailCont = TextEditingController();
  final TextEditingController passCont = TextEditingController();

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: const Color.fromARGB(200, 84, 84, 84),
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Colors.white,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Image.asset(
          //   'images/flunyicon.png',
          //   height: 60,
          // ),
          Text("F L A N K I",
              style: GoogleFonts.aBeeZee(
                  textStyle: const TextStyle(
                      fontSize: 50.0, color: Color.fromARGB(255, 84, 84, 84)))),
        ]),
      ),
      body: Stack(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (!_isKeyboard)
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'images/flunny_2.png',
                    height: 200,
                  )),
          ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginInput(
                myController: mailCont,
                myHintText: 'E-mail',
                myIcon: const Icon(Icons.email),
                myKeyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              LoginInput(
                  myController: passCont,
                  myHintText: 'Password',
                  myIcon: const Icon(Icons.key_rounded),
                  myKeyboardType: TextInputType.visiblePassword),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: Colors.white.withOpacity(0.55),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15)),
                      onPressed: () {
                        print("twoj email to ${mailCont.text}");
                        print("twoje haslo to ${passCont.text}");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const GoogleOptions())));
                      },
                      child: Text("login",
                          style: GoogleFonts.overpass(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ],
              ),
            ],
          ),
          if (!_isKeyboard)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Sign up with :",
                    style: GoogleFonts.overpass(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Google",
                            style: GoogleFonts.overpass(color: Colors.white),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.redAccent),
                            child: IconButton(
                              color: Colors.white,
                              iconSize: 30,
                              onPressed: () {
                                final provider =
                                    Provider.of<GoogleSignInProvider>(context,
                                        listen: false);
                                provider.googleLogin();
                              },
                              icon: const Icon(FontAwesomeIcons.google),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Facebook",
                            style: GoogleFonts.overpass(color: Colors.white),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blueAccent),
                            child: IconButton(
                              color: Colors.white,
                              iconSize: 30,
                              onPressed: () {},
                              icon: const Icon(FontAwesomeIcons.facebook),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
