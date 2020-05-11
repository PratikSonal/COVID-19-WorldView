import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:covid19/pages/drawermenu.dart';
import 'package:covid19/pages_india/homepageIndia.dart';
import 'package:covid19/pages_india/statedetails.dart';
import 'package:covid19/pages_india/statedetailsPrototype.dart';
import 'package:covid19/pages_india/statelist.dart';
import 'package:covid19/tabbar/tabbar3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'tabbar/tabbar1.dart';
import 'tabbar/tabbar2.dart';

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final tabs = [
    FirstTab(),
    Scaffold(
        backgroundColor: Colors.amber, body: Container(child: Text('empty 1'))),
  ];

  static PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 WorldView',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.white,
      ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: Text(
              'COVID-19 WORLDVIEW',
              style: TextStyle(),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () => Phoenix.rebirth(context))
            ],
            //backgroundColor: Color(0xff233656),
            backgroundColor: Color(0xff022c43),
          ),
        ),
        drawer: Drawer(
          child: DrawerMenu(),
        ),
        //body: HomePage(),
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
            pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
          children: <Widget>[
            //tabs[_currentIndex],
            FirstTab(),
            //SecondTab(),
            //PrototypeSelectedStateDetails(),
            ThirdTab(),
          ],
        ),
        //bottomNavigationBar: SizedBox(
        //  height: 60,
        //  child: BottomNavigationBar(
        //    type: BottomNavigationBarType.shifting,
        //    currentIndex: _currentIndex,
        //    items: [
        //      BottomNavigationBarItem(
        //        icon: Icon(Icons.home),
        //        title: Text('1'),
        //        backgroundColor: Colors.blue,
        //      ),
        //      BottomNavigationBarItem(
        //        icon: Icon(Icons.home),
        //        title: Text('2'),
        //        backgroundColor: Colors.blue,
        //      ),
        //    ],
        //    onTap: (index) {
        //      setState(() {
        //        _currentIndex = index;
        //      });
        //    },
        //  ),
        //),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: BottomNavyBar(
            backgroundColor: Color(0xff022c43),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            selectedIndex: _currentIndex,
            items: [
              BottomNavyBarItem(
                icon: Icon(FontAwesomeIcons.globeAsia, size: 20),
                title: Text('WORLD'),
                activeColor: Colors.blueGrey[100],
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(FontAwesomeIcons.mapMarkedAlt, size: 20),
                title: Text('INDIA'),
                activeColor: Colors.blueGrey[100],
                textAlign: TextAlign.center,
              ),
            ],
            onItemSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 350), curve: Curves.ease);
            },
          ),
        ),
      ),
    );
  }
}
