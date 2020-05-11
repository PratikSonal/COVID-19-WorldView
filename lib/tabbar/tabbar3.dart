import 'package:covid19/homepageIndia.dart';
import 'package:covid19/pages_india/statedetails.dart';
import 'package:covid19/statedetailsentrypage.dart';
import 'package:covid19/stateentrypage.dart';
import 'package:flutter/material.dart';

class ThirdTab extends StatefulWidget {
  @override
  ThirdTabState createState() => ThirdTabState();
}

class ThirdTabState extends State<ThirdTab>
    with SingleTickerProviderStateMixin {
  static TabController tabBarController1;

  void initState() {
    super.initState();
    tabBarController1 = TabController(length: 3, vsync: this);
  }

  //void dispose() {
  //  super.dispose();
  //  tabBarController1.dispose();
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: Container(
          height: 30,
          color: Color(0xff00E5FF),
          child: TabBar(
            tabs: <Widget>[
              Text(
                'AT GLANCE',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'STATES',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'DETAILS',
                style: TextStyle(color: Colors.black),
              )
            ],
            controller: tabBarController1,
          ),
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          HomePageIndia(),
          //CountryLoadingPage(),
          //Container(child: Text('Empty, for now :)')),
          StateLoadingPage(),
          //Container(child: Text('Empty, for now :)')),
          StateDetailsEntryPage(),
          //SelectedCountryDetails(),
        ],
        controller: tabBarController1,
      ),
      //bottomNavigationBar: Container(
      //  height: 30,
      //  child: Material(
      //    color: Color(0xff233656),
      //    child: TabBar(
      //      tabs: <Widget>[
      //        Text(
      //          'AT GLANCE',
      //          style: TextStyle(),
      //        ),
      //        Text(
      //          'COUNTRIES',
      //          style: TextStyle(),
      //        ),
      //        Text(
      //          'DETAILS',
      //          style: TextStyle(),
      //        )
      //      ],
      //      controller: tabBarController1,
      //    ),
      //  ),
      //),
    );
  }
}
