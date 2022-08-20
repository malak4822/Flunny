import 'package:firebase_auth/firebase_auth.dart';
import 'package:flany/friendspage.dart';
import 'package:flany/friendspageeditable.dart';
import 'package:flany/loginpage.dart';
import 'package:flany/providers/googlesignin.dart';
import 'package:flany/providers/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => ThemesProvider())
      ],
      child: MaterialApp(
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                //// 2 OPCJA - DODAĆ TU NAVIGATOR I PRZECZYTAĆ TO
                return const FriendsPage();
              } else if (snapshot.hasError) {
                return const Center(child: Text("Something is Wrong.."));
              } else {
                return const LoginPage();
              }
            }),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: Provider.of<ThemesProvider>(context).darkModeOn
            ? ThemeOptions.white
            : ThemeOptions.black,
        home: Scaffold(),
        debugShowCheckedModeBanner: false,
      );
}


// 1 OPCJA - przeniesc StreamBuilder nad MyApp

