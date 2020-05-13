import 'package:covid19/pages/detailspage.dart';
import 'package:covid19/pages/drawermenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../SelectCategory.dart';
import '../countryentrypage.dart';
import '../homepage.dart';

class FirstPage extends StatefulWidget {
  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  static TabController tabBarController1;
  double preferredSize;

  void initState() {
    super.initState();
    tabBarController1 = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double aspectRatio = double.parse(
        (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height)
            .toStringAsFixed(1));
    preferredSize = aspectRatio == 0.6
        ? MediaQuery.of(context).size.height * 0.1
        : MediaQuery.of(context).size.height * 0.08;

    return WillPopScope(
      onWillPop: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => SelectCategory(),
          ),
        );
      },
      child: Scaffold(
        appBar:
            //PreferredSize(
            //preferredSize:
            //Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
            //child: Container(
            //height: MediaQuery.of(context).size.height * 0.1,
            //color: Color(0xff233656),
            //color: Color(0xff14ffec),
            //color: Color(0xff00adb5) ,
            //color: Color(0xff00E5FF),
            //color: Color(0xff49beb7),
            //child:
            PreferredSize(
          preferredSize:
              Size.fromHeight(preferredSize),
          child: AppBar(
            elevation: 5,
            title: Text(
              'W O R L D',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: MediaQuery.of(context).size.width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.cyan[100]),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () => Phoenix.rebirth(context))
            ],
            centerTitle: true,
            bottom: TabBar(
              indicatorWeight: 3,
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Container(
                  height: 20,
                  child: Text(
                    'AT GLANCE',
                    style: TextStyle(color: Colors.cyan[100]),
                  ),
                ),
                Container(
                  height: 20,
                  child: Text(
                    'COUNTRIES',
                    style: TextStyle(color: Colors.cyan[100]),
                  ),
                ),
                Container(
                  height: 20,
                  child: Text(
                    'DETAILS',
                    style: TextStyle(color: Colors.cyan[100]),
                  ),
                )
              ],
              controller: tabBarController1,
            ),
            backgroundColor: Color(0xff022c43), //Color(0xff00e0ff),
          ),
        ),
        //),
        //),
        drawer: Drawer(
          child: DrawerMenu(),
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            CountryLoadingPage(),
            //Container(child: Text('Empty, for now :)')),
            SelectedCountryDetails(),
          ],
          controller: tabBarController1,
        ),
      ),
    );
  }
}
