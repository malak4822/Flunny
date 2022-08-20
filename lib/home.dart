import 'package:flany/friendspage.dart';
import 'package:flany/widgets/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, firTime, secTime}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  List loadedPages = [1];

  @override
  Widget build(BuildContext context) {
    var screens = [
      loadedPages.contains(1) 
      loadedPages.contains(2) ? Game() : Container(),
      loadedPages.contains(3) ? const FriendsPage() : Container(),
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.verified_user), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.games_rounded), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle_outlined), label: ""),
            ],
            currentIndex: _selectedIndex),
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Team",
                style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                  fontSize: 50.0,
                )),
              ),
              Text(
                "[num] 1",
                style: GoogleFonts.overpass(
                    textStyle: const TextStyle(fontSize: 20.0)),
              )
            ],
          ),
        ),
        body: IndexedStack(index: _selectedIndex, children: screens));
  }
}
