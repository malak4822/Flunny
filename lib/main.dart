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
            // colorScheme: ThemeData().colorScheme.copyWith(
            //     primary: Color.fromARGB(255, 31, 199, 180),
            //     secondary: Colors.black),
            ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatelessWidget {
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController mailCont = TextEditingController();
  final TextEditingController passCont = TextEditingController();

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: const Color.fromARGB(199, 84, 84, 84),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("F L A N K I",
            style: GoogleFonts.aBeeZee(
                fontSize: 50.0, color: const Color.fromARGB(255, 84, 84, 84))),
      ),
      body: Column(
        //shrinkWrap: false,
        children: [
          if (!_isKeyboard)
            Expanded(
              flex: 2,
              child: Image.asset(
                'images/flunny_2.png',
              ),
            ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginInput(
                  myController: nameCont,
                  myHintText: 'Nazwa Użytkownika',
                  myIcon: const Icon(Icons.person),
                  myKeyboardType: TextInputType.name,
                ),
                const SizedBox(height: 15),
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
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(30))),
                            foregroundColor:
                                const Color.fromARGB(199, 84, 84, 84),
                            backgroundColor:
                                const Color.fromARGB(255, 120, 239, 255),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15)),
                        onPressed: () {
                          print("twoj email to ${mailCont.text}");
                          print("twoje haslo to ${passCont.text}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const GoogleOptions())));
                        },
                        child: Text("login",
                            style: GoogleFonts.overpass(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(30))),
                            foregroundColor:
                                const Color.fromARGB(199, 84, 84, 84),
                            backgroundColor: Colors.greenAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15)),
                        onPressed: () {
                          print("twoj email to ${mailCont.text}");
                          print("twoje haslo to ${passCont.text}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const GoogleOptions())));
                        },
                        child: Text("Reg",
                            style: GoogleFonts.overpass(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ],
                ),
              ],
            ),
          ),
          if (!_isKeyboard)
            Expanded(
              flex: 1,
              child: Align(
                
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    },
                    icon: const FaIcon(FontAwesomeIcons.google),
                    label: const Text("Zarejestruj się przez"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.redAccent,
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
