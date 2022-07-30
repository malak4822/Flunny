import 'dart:typed_data';
import 'package:flany/game2.dart';
import 'package:flany/zmienne.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'lastresgamepage.dart';

class ResGamePage extends StatefulWidget {
  const ResGamePage({
    Key? key,
  }) : super(key: key);
  @override
  _ResGamePageState createState() => _ResGamePageState();
}

class _ResGamePageState extends State<ResGamePage> {
  final _scrollController = ScrollController();

  _ResGamePageState();

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
    var msdcntr1 = Provider.of<ZmienneClass>(context).missedcounter1;
    var msdcntr2 = Provider.of<ZmienneClass>(context).missedcounter2;
    var suma1 = Provider.of<ZmienneClass>(context).sumaczasu1;
    var suma2 = Provider.of<ZmienneClass>(context).sumaczasu2;
    var _currentrunda = Provider.of<ZmienneClass>(context).aktrunda;
    var _maxirunda = Provider.of<ZmienneClass>(context, listen: false).maxRunda;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ZmienneClass()),
        ],
        child: Screenshot(
            controller: kontroler,
            child: Scaffold(
                body: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 8, 240, 196),
                      Color.fromARGB(255, 8, 236, 124)
                    ])),
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text("Runda: $_currentrunda",
                                style: GoogleFonts.overpass(
                                    color: Colors.white, fontSize: 17.0)),
                          )),
                      Column(children: [
                        const SizedBox(height: 50.0),
                        Text(
                          "Czasy picia drużyn:",
                          style: GoogleFonts.overpass(
                              fontSize: 40.0, color: Colors.white),
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
                                width: 150.0,
                                height: 150.0,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 8, 236, 124),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 2.5,
                                          spreadRadius: 2.5)
                                    ]),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "${suma2 / 1000}",
                                  maxLines: 1,
                                  style: GoogleFonts.overpass(
                                      fontSize: 50.0, color: Colors.white),
                                ),
                                width: 150.0,
                                height: 150.0,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 8, 240, 196),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 2.5,
                                          spreadRadius: 2.5)
                                    ]),
                              ),
                            ]),
                        const SizedBox(height: 60.0),
                        Text(
                          "Nietrafienia drużyn:",
                          style: GoogleFonts.overpass(
                              fontSize: 38.0, color: Colors.white),
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
                              width: 150.0,
                              height: 150.0,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 8, 236, 124),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 2.5,
                                        spreadRadius: 2.5)
                                  ]),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "$msdcntr2",
                                style: GoogleFonts.overpass(
                                    fontSize: 50.0, color: Colors.white),
                              ),
                              width: 150.0,
                              height: 150.0,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 8, 240, 196),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 2.5,
                                        spreadRadius: 2.5)
                                  ]),
                            ),
                          ],
                        ),
                      ]),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 20),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                iconSize: 90.0,
                                onPressed: () {
                                  Provider.of<ZmienneClass>(context,
                                          listen: false)
                                      .dodainCzas();
                                  Provider.of<ZmienneClass>(context,
                                          listen: false)
                                      .savinCzas();
                                  Provider.of<ZmienneClass>(context,
                                          listen: false)
                                      .dodRund();
                                  if (_maxirunda == _currentrunda) {
                                    Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                            transitionsBuilder: (BuildContext
                                                    context,
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
                                            transitionDuration: const Duration(
                                                milliseconds: 300),
                                            pageBuilder: (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double>
                                                    secAnimation) {
                                              return const EndScreen();
                                            }));
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                            transitionsBuilder: (BuildContext
                                                    context,
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
                                            transitionDuration: const Duration(
                                                milliseconds: 300),
                                            pageBuilder: (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double>
                                                    secAnimation) {
                                              return const SecGamePage();
                                            }));
                                  }
                                },
                                color: Colors.white,
                                focusColor: Colors.red,
                                icon: const Icon(Icons.restart_alt),
                              ))),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: IconButton(
                                  iconSize: 90,
                                  onPressed: () async {
                                    final ss = await kontroler.capture();
                                    if (ss == null) return;
                                    await saveImage(ss);
                                  },
                                  icon: const Icon(Icons.screenshot,
                                      color: Colors.white))))
                    ])))));
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");
    final name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result["/Pictures"];
  }
}
