import 'package:curiosoworld/api/restinterface.dart';
import 'package:curiosoworld/custom/custom_caroussel.dart';
import 'package:curiosoworld/custom/custom_header.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15.0),
                child: Header(),
              ),
              Container(color: Theme.of(context).secondaryHeaderColor),
              Padding(
                padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                child: DisplaySelected(),
              )
            ],
          ),
        ),
      ),
     

      
    );
  }
}
