import 'package:curiosoworld/api/restinterface.dart';
import 'package:curiosoworld/model/news.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DisplaySelected extends StatefulWidget {
  DisplaySelected({Key key}) : super(key: key);

  @override
  _DisplaySelectedState createState() => _DisplaySelectedState();
}


class _DisplaySelectedState extends State<DisplaySelected> {
  int _items = -1;
  int amount = 5;
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: CarouselSlider(
        autoPlayInterval: Duration(seconds: 3),
        enlargeCenterPage: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        height: 200.0,
        items: List.generate(amount, (int index) => index  ).map((i) {
          return FutureBuilder(
            future: RestInterface.getTopHeadlinesBrasil(amount),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              
              return snapshot.connectionState != ConnectionState.waiting ? 
                  NewsCard(data: snapshot.data[i])
                  :CircularProgressIndicator();
            },
          );
        }).toList(),
      ),
    );
  }
}


class NewsCard extends StatefulWidget {
  final News data;

  NewsCard({@required this.data});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  double _rotationAngle = 0;

  Container destinationRating(int index) {
    return Container(
      child: Text(
        "${widget.data.title}",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
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
          "${widget.data.author}",
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
              Icons.location_on,
              size: 10,
              color: Colors.white,
            ),
            Container(width: 2.0),
            Text(
              "${widget.data.author}",
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

  Container userAvatar(int index) {
    return Container(
      width: 35.0,
      height: 35.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: Colors.blue,
        image: DecorationImage(
          image: AssetImage("assets/earth_icon.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  Container imageCard(int index) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: NetworkImage(widget.data.urlToImage),
          fit: BoxFit.cover,
        ),
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
        child:
             Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_rotationAngle),
                alignment: Alignment.center,
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
                            children: <Widget>[
                              userAvatar(0),
                              Container(width: 8),
                              userInfo(0),
                              Expanded(child: Container()),
                            ],
                          ),
                destinationRating(0),                          

                        ],
                      ),
                    ),
                  ],
                ),
              ),
          
        ),
      ),
    );
  }
}
