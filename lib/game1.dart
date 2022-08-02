import 'package:flany/game2.dart';
import 'package:flany/res1.dart';
import 'package:flany/results.dart';
import 'package:flutter/material.dart';
import 'package:flany/providers/zmienne.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class FirGamePage extends StatefulWidget {
  const FirGamePage({Key? key, firTime, secTime}) : super(key: key);
  @override
  _FirGamePageState createState() => _FirGamePageState();
}

class _FirGamePageState extends State<FirGamePage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
    _scrollController;
  }

  var msdcntr1 = 0;
  var _currenttime1;
  @override
  Widget build(BuildContext context) {
    var _currentrunda = Provider.of<ZmienneClass>(context).aktrunda;
    var _gracze = Provider.of<ZmienneClass>(context).iloscGraczy;
    return Scaffold(
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
                "Team",
                style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                        fontSize: 50.0,
                        color: Color.fromARGB(255, 84, 84, 84))),
              ),
              Text(
                "[num] 1",
                style: GoogleFonts.overpass(
                    textStyle:
                        const TextStyle(fontSize: 20.0, color: Colors.black45)),
              )
            ],
          ),
        ),
        body: PageView(
          scrollDirection: Axis.vertical,
          children: [
            PageView(
              children: [
                Stack(children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Osoby: $_gracze",
                            style: GoogleFonts.overpass(
                                color: Colors.white, fontSize: 20.0)),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text("Runda nr: $_currentrunda",
                              style: GoogleFonts.overpass(
                                  color: Colors.white, fontSize: 20.0)))),
                  ListView(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 50.0),
                          Center(
                            child: StreamBuilder<int>(
                                stream: _stopWatchTimer.rawTime,
                                initialData: _stopWatchTimer.rawTime.value,
                                builder: (context, snapshot) {
                                  final value = snapshot.data;
                                  _currenttime1 = value;
                                  final displayTime =
                                      StopWatchTimer.getDisplayTime(value!,
                                          hours: false, minute: false);

                                  return Text(displayTime,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                      maxLines: 1,
                                      style: GoogleFonts.overpass(
                                        color: Colors.white,
                                        fontSize: 90.0,
                                      ));
                                }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.start);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white12,
                                  side: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(225, 8, 236, 124)),
                                  padding: const EdgeInsets.all(50),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                  )),
                              child: const Icon(Icons.circle,
                                  color: Colors.black26, size: 40)),
                          const SizedBox(width: 40.0),
                          //
                          //PRZYCISK TRAFIONY
                          //
                          ElevatedButton(
                              onPressed: () {
                                _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.stop);
                                _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.lap);
                                Provider.of<ZmienneClass>(context,
                                        listen: false)
                                    .dodajczas1(_currenttime1);
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        transitionsBuilder:
                                            (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double> secAnimation,
                                                Widget child) {
                                          animation = CurvedAnimation(
                                              parent: animation,
                                              curve: Curves
                                                  .fastLinearToSlowEaseIn);

                                          return ScaleTransition(
                                            scale: animation,
                                            child: child,
                                            alignment: Alignment.center,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 300),
                                        pageBuilder: (BuildContext context,
                                            Animation<double> animation,
                                            Animation<double> secAnimation) {
                                          return SecGamePage(
                                              firTime: _currenttime1);
                                        }));
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white12,
                                  side: const BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(225, 8, 236, 124)),
                                  padding: const EdgeInsets.all(42.5),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                  )),
                              child: const Icon(Icons.stop_rounded,
                                  color: Colors.black26, size: 55)),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(children: [
                        Text("Missed",
                            style: GoogleFonts.josefinSans(
                                fontSize: 40.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                        //
                        //PRZYCISK NIE TRAFIONO
                        //
                        ElevatedButton(
                            onPressed: () {
                              Provider.of<ZmienneClass>(context, listen: false)
                                  .liczenienietrafien1();

                              Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                      transitionsBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secAnimation,
                                          Widget child) {
                                        animation = CurvedAnimation(
                                            parent: animation,
                                            curve:
                                                Curves.fastLinearToSlowEaseIn);

                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                          alignment: Alignment.center,
                                        );
                                      },
                                      transitionDuration:
                                          const Duration(milliseconds: 300),
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secAnimation) {
                                        return const SecGamePage();
                                      }));
                            },
                            child: const Icon(Icons.close,
                                color: Color.fromARGB(225, 8, 236, 124),
                                size: 70),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white12,
                              side: const BorderSide(
                                  color: Colors.white, width: 1.0),
                              padding: const EdgeInsets.all(80.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                            )),
                        const SizedBox(height: 40.0),
                      ])),
                ]),
                const ResoneGamePage()
              ],
            ),
            const ResGamePage()
          ],
        ));
  }
}
