import 'dart:math';

import 'package:flany/game1.dart';
import 'package:flany/main.dart';
import 'package:flany/zmienne.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key, value}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

int liczbagraczy = 0;

class _InfoPageState extends State<InfoPage> {
  TextEditingController graczeCon = TextEditingController();
  TextEditingController maxRundyCon = TextEditingController();

  List<int> liczbynieparzyste = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: ZmienneClass())],
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 84, 84, 84),
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Info",
                    style: GoogleFonts.josefinSans(
                        textStyle: const TextStyle(
                            fontSize: 50.0,
                            color: Color.fromARGB(255, 84, 84, 84))),
                  ),
                  Text(
                    "Gathering",
                    style: GoogleFonts.overpass(
                        textStyle: const TextStyle(
                            fontSize: 20.0, color: Colors.black45)),
                  )
                ],
              ),
            ),
            body: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 250.0,
                      child: TextFormField(
                        onChanged: (gracze) {},
                        controller: graczeCon,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp("3,5,7,9"))
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Liczba graczy",
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 20.0),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Center(
                    child: SizedBox(
                      width: 250.0,
                      child: TextFormField(
                        onChanged: (rundy) {},
                        controller: maxRundyCon,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp("3,5,7,9"))
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Liczba Rund",
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 20.0),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80.0),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Transform.rotate(
                        angle: pi,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyApp()));
                          },
                          iconSize: 70.0,
                          splashColor: Colors.black,
                          highlightColor: Colors.black45,
                          icon: const Icon(Icons.not_started_rounded,
                              color: Colors.white),
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {
                      Provider.of<ZmienneClass>(context, listen: false)
                          .setPlayerCount(
                              liczbagraczy: int.parse(graczeCon.text));

                      Provider.of<ZmienneClass>(context, listen: false)
                          .setRoundCount(maxRundy: int.parse(maxRundyCon.text));
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FirGamePage()));
                      }
                    },
                    iconSize: 70.0,
                    splashColor: Colors.black,
                    highlightColor: Colors.black45,
                    icon: const Icon(Icons.not_started_rounded,
                        color: Colors.white),
                  ),
                ),
              )
            ])));
  }
}
