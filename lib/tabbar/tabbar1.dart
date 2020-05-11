import 'package:covid19/pages/countrypage.dart';
import 'package:covid19/pages/detailspage.dart';
import 'package:covid19/widgets/selectedCountry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../countryentrypage.dart';
import '../homepage.dart';

class FirstTab extends StatefulWidget {
  @override
  FirstTabState createState() => FirstTabState();
}

class FirstTabState extends State<FirstTab>
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
          //color: Color(0xff233656),
          //color: Color(0xff14ffec),
          //color: Color(0xff00adb5) ,
          color: Color(0xff00E5FF),
          child: TabBar(
            tabs: <Widget>[
              Text(
                'AT GLANCE',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'COUNTRIES',
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
          HomePage(),
          CountryLoadingPage(),
          //Container(child: Text('Empty, for now :)')),
          SelectedCountryDetails(),
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
