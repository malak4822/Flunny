import 'package:flany/providers/zmienne.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ResoneGamePage extends StatefulWidget {
  final firTime;
  final secTime;
  final missed;
  final missed1;
  const ResoneGamePage(
      {Key? key, this.firTime, this.secTime, this.missed, this.missed1})
      : super(key: key);
  @override
  _ResoneGamePageState createState() => _ResoneGamePageState();
}

class _ResoneGamePageState extends State<ResoneGamePage> {
  final _scrollController = ScrollController();

  _ResoneGamePageState();

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
    _scrollController;
  }

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  @override
  Widget build(BuildContext context) {
    var _gracze = Provider.of<ZmienneClass>(context).plrsInEachTeam;
    var msdcntr1 = Provider.of<ZmienneClass>(context).missedcounter1;
    var suma1 = Provider.of<ZmienneClass>(context).sumaczasu1;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ZmienneClass()),
        ],
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 84, 84, 84),
            body: Stack(alignment: Alignment.bottomCenter, children: [
              Column(children: [
                const SizedBox(height: 50.0),
                Text(
                  "Czas picia drużyny:",
                  style:
                      GoogleFonts.overpass(fontSize: 40.0, color: Colors.white),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${suma1 / 1000}",
                          maxLines: 1,
                          style: GoogleFonts.overpass(
                              fontSize: 50.0, color: Colors.white),
                        ),
                        width: 200.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.white),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 8, 240, 196),
                            Color.fromARGB(255, 8, 236, 124)
                          ]),
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.white12,
                                blurRadius: 14,
                                spreadRadius: 10)
                          ],
                        ),
                      ),
                    ]),
                const SizedBox(height: 40.0),
                Text(
                  "Nietrafienia drużyny:",
                  style:
                      GoogleFonts.overpass(fontSize: 38.0, color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "$msdcntr1",
                        style: GoogleFonts.overpass(
                            fontSize: 50.0, color: Colors.white),
                      ),
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.white),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 8, 240, 196),
                          Color.fromARGB(255, 8, 236, 124)
                        ]),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.white12,
                              blurRadius: 14,
                              spreadRadius: 10)
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
              Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "W drużynie jest po $_gracze graczy",
                    style: GoogleFonts.overpass(
                        fontSize: 20.0, color: Colors.white),
                  )),
            ])));
  }
}
