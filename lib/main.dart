import 'package:flany/googlesignin.dart';
import 'package:flany/widgets/classes/inputwindows.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

/////////// ZMIENNE OGÓLNE ///////////////
Color _firColor = Colors.black;
Color _secColor = const Color.fromARGB(199, 84, 84, 84);
bool _isRegisterClicked = false;
double _myOpacity = 1;
bool isTextObscured = true;
////////// KONIEC ZMIENNYCH OGÓLNYCH /////

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => GoogleSignInProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData().copyWith(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: Colors.white, secondary: Colors.black),
        ),
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, isTextObscured}) : super(key: key);
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
      backgroundColor: const Color.fromARGB(199, 84, 84, 84),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("F L A N K I",
            style: GoogleFonts.aBeeZee(
                fontSize: 50.0, color: const Color.fromARGB(255, 84, 84, 84))),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!_isKeyboard)
            const Image(
              image: ResizeImage(AssetImage('images/flunny_2_better.png'),
                  height: 200),
            ),
          const SizedBox(height: 30),
          if (_isRegisterClicked)
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _myOpacity,
              child: LoginInput(
                myController: nameCont,
                myHintText: 'Użytkownik',
                myPrefixIcon: const Icon(Icons.person),
                myKeyboardType: TextInputType.name,
              ),
            ),
          if (_isRegisterClicked) const SizedBox(height: 15),
          LoginInput(
            myController: mailCont,
            myHintText: 'Email',
            myPrefixIcon: const Icon(Icons.email),
            myKeyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15),
          LoginInput(
              isTextObscured: isTextObscured,
              mySuffIcon: IconButton(
                  icon: const Icon(Icons.security),
                  onPressed: () {
                    setState(() {
                      isTextObscured = !isTextObscured;
                    });
                  }),
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
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(30))),
                      foregroundColor: _firColor,
                      backgroundColor: const Color.fromARGB(255, 120, 239, 255),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15)),
                  onPressed: () {
                    setState(() {
                      if (_isRegisterClicked == true) {
                        _isRegisterClicked = false;
                      }
                    });
                    _firColor = Colors.black;
                    _secColor = const Color.fromARGB(199, 84, 84, 84);
                    // print("twoj email to ${mailCont.text}");
                    // print("twoje haslo to ${passCont.text}");
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => const GoogleOptions())));
                  },
                  child: Text("login",
                      style: GoogleFonts.overpass(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(30))),
                      foregroundColor: _secColor,
                      backgroundColor: Colors.greenAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15)),
                  onPressed: () {
                    setState(() {
                      if (_isRegisterClicked == false) {
                        _isRegisterClicked = true;
                      }
                      _myOpacity = _myOpacity == 0 ? 1.0 : 0;
                    });
                    _firColor = const Color.fromARGB(199, 84, 84, 84);
                    _secColor = Colors.black;

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => const GoogleOptions())));
                  },
                  child: Text("Register",
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
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
                  icon: const FaIcon(FontAwesomeIcons.google),
                  label: const Text("Zarejestruj się przez"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(15, 0, 20, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.black45,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(50))),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
