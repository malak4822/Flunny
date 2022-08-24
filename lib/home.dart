import 'package:flany/userpage.dart';
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
      loadedPages.contains(0)
          ? const Center(child: Text("pierwesza strona"))
          : const Center(child: CircularProgressIndicator()),
      loadedPages.contains(1)
          ? Game()
          : const Center(child: CircularProgressIndicator()),
      loadedPages.contains(2)
          ? const UserPage()
          : const Center(child: CircularProgressIndicator()),
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });

              switch (index) {
                case 0:
                  {
                    loadedPages.clear();
                    loadedPages.add(0);
                  }
                  break;
                case 1:
                  {
                    loadedPages.clear();
                    loadedPages.add(1);
                  }
                  break;
                case 2:
                  {
                    loadedPages.clear();
                    loadedPages.add(2);
                  }
                  break;
              }
            },
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.score), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.games_rounded), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: ""),
            ],
            currentIndex: _selectedIndex),
        body: IndexedStack(index: _selectedIndex, children: screens));
  }
}
