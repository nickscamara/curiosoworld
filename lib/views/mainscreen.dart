import 'package:curiosoworld/api/restinterface.dart';
import 'package:curiosoworld/custom/custom_caroussel.dart';
import 'package:curiosoworld/custom/custom_header.dart';
import 'package:curiosoworld/custom/navbar.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {

  List<NavBarItemData> _navBarItems;

  int _selectedNavIndex = 0;
  double _safeSize = 0.5;


  List<Widget> _viewsByIndex;
   @override
  void initState() {
    //Declare some buttons for our tab bar

    //Create the views which will be mapped to the indices for our nav btns
    _viewsByIndex = <Widget>[
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _navBarItems = [
      NavBarItemData("Home", OMIcons.home, 125, Color(0xff1f4287)),
      NavBarItemData("Trending", OMIcons.trendingUp, 125, Color(0xff1f4287)),
      NavBarItemData("My Travels", OMIcons.cardTravel, 125, Color(0xff1f4287)),
      NavBarItemData("Profile", OMIcons.person, 125, Color(0xff1f4287)),
    ];
    var navBar = NavBar(
      items: _navBarItems,
      itemTapped: _handleNavBtnTapped,
      currentIndex: _selectedNavIndex,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:_viewsByIndex[_selectedNavIndex],
      bottomNavigationBar: navBar,
     

      
    );
  }
  void _handleNavBtnTapped(int index) {
    //Save the new index and trigger a rebuild
    setState(() {
      //This will be passed into the NavBar and change it's selected state, also controls the active content page
      _selectedNavIndex = index;
      if(index!=0)
      {
        _safeSize = .2;
      }else
      {
        _safeSize = .5;
      }
      

    });
  }
}


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15.0),
                child: Header("Where Next?","Viage o mundo"),
              ),
              Container(color: Theme.of(context).secondaryHeaderColor),
              Padding(
                padding: const EdgeInsets.only(top:15.0,bottom: 15.0),
                child: DisplaySelected(),
              ),
            ],
          ),
        ),
        
      );
  }
}