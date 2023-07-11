// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flany/providers/zmienne.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

@immutable
class Game extends StatelessWidget {
  Game({Key? key}) : super(key: key);

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _scrollController = ScrollController();

  void dispose() {
    _stopWatchTimer.dispose();
    _scrollController;
  }

  final Color greenie = const Color.fromARGB(225, 8, 236, 124);
  final int _teamNumb = 1;
  final msdcntr1 = 0;
  var _currenttime1;

  @override
  Widget build(BuildContext context) {
    //
    Widget topTexts(String nazwa, vard) => Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text("$nazwa: $vard",
              style: GoogleFonts.overpass(fontSize: 20.0)),
        ));

    var _currentrunda = Provider.of<ZmienneClass>(context).aktrunda;
    var _gracze = Provider.of<ZmienneClass>(context).iloscGraczy;
    return Scaffold(
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
              "[num] $_teamNumb",
              style: GoogleFonts.overpass(
                  textStyle: const TextStyle(fontSize: 20.0)),
            )
          ],
        ),
      ),
      body: Column(children: [
        Expanded(
            flex: 2,
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                topTexts("Osoby", _gracze),
                topTexts("Nr rundy", _currentrunda),
              ]),
              StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (context, snapshot) {
                    final value = snapshot.data;
                    _currenttime1 = value;
                    final displayTime = StopWatchTimer.getDisplayTime(value!,
                        hours: false, minute: false);

                    return Text(displayTime,
                        textWidthBasis: TextWidthBasis.longestLine,
                        maxLines: 1,
                        style: GoogleFonts.overpass(
                            fontSize: MediaQuery.of(context).size.width / 4));
                  })
            ])),
        Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _stopWatchTimer.onStartTimer();
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 1, color: greenie),
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 8),
                        shape: const CircleBorder()),
                    child: const Icon(Icons.circle, size: 30)),

                //
                //PRZYCISK TRAFIONY
                //
                ElevatedButton(
                    onPressed: () {
                      _stopWatchTimer.onStopTimer();
                      _stopWatchTimer.onAddLap();
                      Provider.of<ZmienneClass>(context, listen: false)
                          .dodajczas1(_currenttime1);
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 1, color: greenie),
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 8),
                        shape: const CircleBorder()),
                    child: const Icon(Icons.stop_rounded, size: 30)),
              ],
            )),
        Expanded(
            flex: 3,
            child: Column(children: [
              Text("Missed",
                  style: GoogleFonts.josefinSans(
                      fontSize: 40.0, fontWeight: FontWeight.w400)),
              //
              //PRZYCISK NIE TRAFIONO
              //
              ElevatedButton(
                  onPressed: () {
                    Provider.of<ZmienneClass>(context, listen: false)
                        .liczenienietrafien1();
                  },
                  child: Icon(Icons.close, color: greenie, size: 50),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1.0),
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 12),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  )),
            ])),
      ]),
      //    const ResoneGamePage()

      //  const ResGamePage()
    );
  }
}
