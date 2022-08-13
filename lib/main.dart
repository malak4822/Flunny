import 'package:firebase_auth/firebase_auth.dart';
import 'package:flany/friendspage.dart';
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
      ChangeNotifierProvider(create: (_) => ThemesProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: Provider.of<ThemesProvider>(context).darkModeOn
            ? ThemeOptions.white
            : ThemeOptions.black,
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            print("rebuild");
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("1");
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              print("2");
              return const FriendsPage();
            } else if (snapshot.hasError) {
              print("3");
              return const Center(child: Text("Something is Wrong.."));
            } else {
              print("4");
              return const LoginPage();
            }
          }),
    );
  }
}
