import 'package:flany/game2.dart';
//import 'package:flany/res1.dart';
//import 'package:flany/results.dart';
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

  Color greenie = const Color.fromARGB(225, 8, 236, 124);

  // int _selectedIndex = 0;
  var msdcntr1 = 0;
  var _currenttime1;
  @override
  Widget build(BuildContext context) {
    var _currentrunda = Provider.of<ZmienneClass>(context).aktrunda;
    var _gracze = Provider.of<ZmienneClass>(context).iloscGraczy;
    return Scaffold(
        // bottomNavigationBar:
        //     BottomNavigationBar(items: const <BottomNavigationBarItem>[
        //   BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: "a"),
        //   BottomNavigationBarItem(
        //       icon: Icon(Icons.supervised_user_circle_outlined), label: "b"),
        //   BottomNavigationBarItem(icon: Icon(Icons.games_rounded), label: "c")
        // ], currentIndex: _selectedIndex)
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
        body: PageView(
          scrollDirection: Axis.vertical,
          children: [
            PageView(
              children: [
                Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Osoby: $_gracze",
                                  style: GoogleFonts.overpass(fontSize: 20.0)),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text("Runda nr: $_currentrunda",
                                    style:
                                        GoogleFonts.overpass(fontSize: 20.0))))
                      ]),
                  StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (context, snapshot) {
                        final value = snapshot.data;
                        _currenttime1 = value;
                        final displayTime = StopWatchTimer.getDisplayTime(
                            value!,
                            hours: false,
                            minute: false);

                        return Text(displayTime,
                            textWidthBasis: TextWidthBasis.longestLine,
                            maxLines: 1,
                            style: GoogleFonts.overpass(
                              fontSize: 90.0,
                            ));
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.start);
                          },
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 1, color: greenie),
                              padding: const EdgeInsets.all(50),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              )),
                          child: const Icon(Icons.circle, size: 40)),

                      //
                      //PRZYCISK TRAFIONY
                      //
                      ElevatedButton(
                          onPressed: () {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.stop);
                            _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                            Provider.of<ZmienneClass>(context, listen: false)
                                .dodajczas1(_currenttime1);
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                    transitionsBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secAnimation,
                                        Widget child) {
                                      animation = CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.fastLinearToSlowEaseIn);

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
                              side: BorderSide(width: 1, color: greenie),
                              padding: const EdgeInsets.all(42.5),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              )),
                          child: const Icon(Icons.stop_rounded, size: 55)),
                    ],
                  ),
                  Column(children: [
                    const SizedBox(height: 30),
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

                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  transitionsBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secAnimation,
                                      Widget child) {
                                    animation = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.fastLinearToSlowEaseIn);

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
                        child: Icon(Icons.close, color: greenie, size: 70),
                        style: ElevatedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.white, width: 1.0),
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height / 10),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        )),
                    const SizedBox(height: 40.0),
                  ]),
                ]),
                //    const ResoneGamePage()
              ],
            ),
            //  const ResGamePage()
          ],
        ));
  }
}
