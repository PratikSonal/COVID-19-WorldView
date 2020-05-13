import 'package:covid19/apiresources/apiStackChart.dart';
import 'package:covid19/myapp.dart';
import 'package:covid19/pages/error.dart';
import 'package:covid19/pages/loading.dart';
import 'package:covid19/tabbar/tabbar1.dart';
import 'package:covid19/widgets/selectedCountry.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import './countrypage.dart';

class SelectedCountryDetails extends StatefulWidget {
  @override
  _SelectedCountryDetailsState createState() => _SelectedCountryDetailsState();
}

class _SelectedCountryDetailsState extends State<SelectedCountryDetails>
    with AutomaticKeepAliveClientMixin<SelectedCountryDetails> {
  var countryMaxDetail = CountryPageState.countryMaxDetails;

  var countryStack = CountryPageState.countryStackIndex;
  //= CountryPageState.countryStackIndex == null
  //? null
  //: CountryPageState.countryStackIndex;

  Future getStackData() {
    countryStack = fetchChartData(
      'https://corona.lmao.ninja/v2/historical/$countryStack',
      30,
      1,
      0,
      'stack$countryStack',
      60,
    );
    //print('hi' + countryStack.toString());
    return countryStack;
  }

  @override
  Widget build(BuildContext context) {
    //return Padding(
    //  padding: EdgeInsets.only(
    //      left: MediaQuery.of(context).size.width * 0.02,
    //      right: MediaQuery.of(context).size.width * 0.02,
    //      top: 0,
    //      bottom: 0),
    // child: Container(
    //    color: Colors.black,
    //    width: MediaQuery.of(context).size.width * 0.99,
    //    child: Center(
    //      child: ListView(
    //        children: <Widget>[
    //          SelectedCountry(
    //              countryMaxDetail, countryStack == null ? null : countryStack),
    //          SizedBox(height: 20),
    //        ],
    //      ),
    //    ),
    //  ),
    //);
    return
        //SwipeDetector(
        //  onSwipeRight: () => FirstTabState.tabBarController1.animateTo(1),
        //  onSwipeLeft: () => MyAppState.pageController.animateToPage(1,
        //      duration: Duration(milliseconds: 150), curve: Curves.ease),
        //  child:
        FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          print('Loading...');
          return Scaffold(
            backgroundColor: Color(0xff022c43),
            body: LoadingPage(),
          );
        } else if (snapshot.data == null2) {
          return Scaffold(
            backgroundColor: Color(0xff022c43),
            body: ErrorPage('Connection timed out', 'Please try again'),
          );
        } else if (snapshot.data == null3) {
          return Scaffold(
            backgroundColor: Color(0xff022c43),
            body: ErrorPage(
                'Network error', 'Please connect to a network and try again'),
          );
        } else {
          return Scaffold(
            //backgroundColor: Color(0xff202f4e),
            backgroundColor: Color(0xff053f5e),
            body: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01,
                  right: MediaQuery.of(context).size.width * 0.01,
                  top: 0,
                  bottom: 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.99,
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      SelectedCountry(countryMaxDetail, snapshot.data),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        //return snapshot.data;
      },
      future: getStackData(),
      //    ),
      //  ),
      //),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
