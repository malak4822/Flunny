import 'package:firebase_auth/firebase_auth.dart';
import 'package:flany/friendspage.dart';
import 'package:flany/friendspageeditable.dart';
import 'package:flany/game1.dart';
import 'package:flany/loginpage.dart';
import 'package:flany/providers/googlesignin.dart';
import 'package:flany/providers/themes.dart';
import 'package:flany/providers/zmienne.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ZmienneClass()),
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (_) => ThemesProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        routes: {"edit": (_) => const FriendsPageEditable()},
        builder: (context, child) => Scaffold(
          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                //// 2 OPCJA - DODAĆ TU NAVIGATOR I PRZECZYTAĆ TO
                return FriendsPage();
              } else if (snapshot.hasError) {
                return const Center(child: Text("Something is Wrong.."));
              } else {
                return const LoginPage();
              }
            },
          ),
        ),
        theme: Provider.of<ThemesProvider>(context).darkModeOn
            ? ThemeOptions.white
            : ThemeOptions.black,
        debugShowCheckedModeBanner: false,
      );
}
