import 'dart:ui';

import 'package:curiosoworld/api/restinterface.dart';
import 'package:curiosoworld/model/country.dart';
import 'package:curiosoworld/model/news.dart';
import 'package:curiosoworld/model/travel.dart';
import 'package:curiosoworld/views/destinationscreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DisplaySelected extends StatefulWidget {
  DisplaySelected({Key key}) : super(key: key);

  @override
  _DisplaySelectedState createState() => _DisplaySelectedState();
}

class _DisplaySelectedState extends State<DisplaySelected> {
  int amount = 5;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        autoPlayInterval: Duration(seconds: 3),
        enlargeCenterPage: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        height: 200.0,
        items: List.generate(amount, (int index) => index).map((i) {
          return FutureBuilder(
            future: RestInterface.getTravels(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.connectionState != ConnectionState.waiting
                  ? CountryCard(data: snapshot.data[i])
                  : CircularProgressIndicator();
            },
          );
        }).toList(),
      ),
    );
  }
}

class CountryCard extends StatefulWidget {
  final Travel data;

  CountryCard({@required this.data});

  @override
  _CountryCardState createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
  double _rotationAngle = 0;

  Container destinationRating(int index) {
    return 
       Container(
        child: Text(
          "${widget.data.place}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      
    );
  }

  Column userInfo(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.data.nameOfBook,
          //"${widget.data.title}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.date_range,
              size: 10,
              color: Colors.white,
            ),
            Container(width: 2.0),
            Text(
              "10 noites",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        )
      ],
    );
  }

  Container imageCard(int index) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
            image: AssetImage(widget.data.img), fit: BoxFit.fill),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 7,
            spreadRadius: 3,
            color: Colors.blue[900].withOpacity(0.1),
          )
        ],
      ),
    );
  }

  Container userAvatar(int index) {
    return Container(
      width: 35.0,
      height: 35.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(widget.data.profileImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          setState(() {
            double newSpeed = notification.scrollDelta * 0.03;
            double deltaSpeed = (newSpeed.abs() - _rotationAngle.abs()).abs();
            if (newSpeed.abs() < 0.8) {
              if (deltaSpeed <= 0.3) {
                _rotationAngle = -1 * newSpeed;
              }
              // print(deltaSpeed);
            }
          });
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 240,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_rotationAngle),
            alignment: Alignment.center,
            child:  GestureDetector(
              onTap: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TravelScreen(travel: widget.data,
                    ),
                  ),),
                          child: Hero(
                                tag: widget.data.img,
                            child: Stack(
                              
                  children: <Widget>[
                    imageCard(0),
                    Container(
                      margin: EdgeInsets.only(right: 18),
                      padding: const EdgeInsets.only(
                        top: 18,
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              userAvatar(0),
                              Container(width: 8),
                              userInfo(0),
                              Expanded(child: Container()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: 
                           Padding(
                             padding: const EdgeInsets.only(right:15.0),
                             child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0x25000000)),
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  
                                    child: FittedBox(child: destinationRating(0)),
                                  ),
                              ),
                              ),
                          ),
                           ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
