import 'package:curiosoworld/theme.dart';
import 'package:curiosoworld/views/mainscreen.dart';
import 'package:curiosoworld/views/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'api/restinterface.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: newTheme,
      home: MainScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _visibleText = true;
  bool _visibleBtn = true;
  double _animHeight = 200.0;
  double _animWidth = 200.0;
  bool _finalAnim = false;
  bool _nextPage = false;
  Color _color = Color(0x00ffffff);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: AnimatedOpacity(
          onEnd: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CarRentalSignupScreen()),
            );
          },
          duration: Duration(seconds: 2),
          opacity: _nextPage ? 0.0 : 1.0,
          child: Container(
            // Add box decoration
            decoration: BoxDecoration(
              // Box decoration takes a gradient
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.5, 1],
                colors: [
                  // Colors are easy thanks to Flutter's Colors class.
                  Color(0xff000428),
                  Color(0xff004e92),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                      ),
                      AnimatedOpacity(
                        opacity: _visibleText ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 500),
                        child: Text("Bem-vindo ao",
                            style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15))),
                      ),
                      _finalAnim == false
                          ? AnimatedOpacity(
                              opacity: _visibleText ? 1.0 : 0.0,
                              onEnd: () {
                                print("final anim");
                                setState(() {
                                  _finalAnim = true;
                                });
                              },
                              duration: Duration(milliseconds: 500),
                              child: Text("Curioso World",
                                  style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45))),
                            )
                          : AnimatedOpacity(
                              opacity: _finalAnim ? 1.0 : 0.0,
                              duration: Duration(seconds: 2),
                              child: Text("Vamos Explorar",
                                  style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45))),
                            ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        height: _animHeight,
                        width: _animWidth,
                        child: FlareActor(
                          "assets/animations/earth.flr",
                          animation: "Preview2",
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _finalAnim == false
                        ? AnimatedOpacity(
                            opacity: _visibleBtn ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 500),
                            child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                ),
                                child: Text(
                                  "Começar Jornada",
                                  style: TextStyle(color: Colors.blue[700]),
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    _visibleText = false;
                                    _visibleBtn = false;
                                    _animHeight = 400;
                                    _animWidth = 400;
                                  });
                                }),
                          )
                        : Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: AnimatedOpacity(
                                opacity: _finalAnim ? 1.0 : 0.0,
                                duration: Duration(seconds: 10),
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _nextPage = true;
                                      _color = Colors.white;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
