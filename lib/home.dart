import 'package:flany/userpage.dart';
import 'package:flany/widgets/game.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, firTime, secTime}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    var screens = [
      Container(),
      Game(),
      const UserPage(),
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.score), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.games_rounded), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
            ],
            currentIndex: _selectedIndex),
        body: IndexedStack(index: _selectedIndex, children: screens));
  }
}
