import 'package:flany/zmienne.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class EndScreen extends StatefulWidget {
  const EndScreen({
    Key? key,
  }) : super(key: key);
  @override
  _EndScreen createState() => _EndScreen();
}

class _EndScreen extends State<EndScreen> {
  final _scrollController = ScrollController();

  _EndScreen();

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
    _scrollController;
  }

  final kontroler = ScreenshotController();

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  @override
  Widget build(BuildContext context) {
    var beteam = Provider.of<ZmienneClass>(context).wonteam;
    double czasostateczny = Provider.of<ZmienneClass>(context).koncowy;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ZmienneClass()),
        ],
        child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 8, 240, 196),
                  Color.fromARGB(255, 8, 236, 124)
                ])),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white12,
              shadowColor: Colors.transparent,
              title: Text(
                "EndScreen",
                style: GoogleFonts.josefinSans(
                    fontSize: 50.0, color: Colors.white),
              ),
            ),
            body: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 8, 240, 196),
                  Color.fromARGB(255, 8, 236, 124)
                ])),
                child: Center(
                    child: Stack(children: [
                  Column(
                    children: [
                      const SizedBox(height: 70.0),
                      Text("Lepszy czas ma drużyna nr. $beteam",
                          style: GoogleFonts.overpass(
                              color: Colors.white, fontSize: 24.0)),
                      Container(
                        height: 200.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Center(
                            child: Text(
                          "${czasostateczny / 1000}",
                          style: GoogleFonts.overpass(
                              color: Colors.white, fontSize: 30.0),
                        )),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                              iconSize: 80.0,
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              icon: const Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                              ))))
                ])))));
  }
}
