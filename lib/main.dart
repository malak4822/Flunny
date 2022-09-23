import 'package:firebase_auth/firebase_auth.dart';
import 'package:flany/loginpage.dart';
import 'package:flany/providers/googlesignin.dart';
import 'package:flany/providers/themes.dart';
import 'package:flany/providers/zmienne.dart';
import 'package:flany/userpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.ios);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
    ChangeNotifierProvider(create: (_) => ThemesProvider()),
    ChangeNotifierProvider(create: (_) => ZmienneClass())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemesProvider>(context).darkModeOn
            ? ThemeOptions.white
            : ThemeOptions.black,
        home: Scaffold(
          body: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                //// 2 OPCJA - DODAĆ TU NAVIGATOR I PRZECZYTAĆ TO
                return const UserPage();
              } else if (snapshot.hasError) {
                return const Center(child: Text("Something went Wrong.."));
              } else {
                return const LoginPage();
              }
            },
            stream: FirebaseAuth.instance.authStateChanges(),
          ),
        ),
      );
}



// 1 OPCJA - przeniesc StreamBuilder nad MyApp



// 1 OPCJA - przeniesc StreamBuilder nad MyApp

