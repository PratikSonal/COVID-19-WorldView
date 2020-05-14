import 'package:covid19/pages/drawermenu.dart';
import 'package:covid19/pages_mod/firstpage.dart';
import 'package:covid19/tabbar/tabbar1.dart';
import 'package:covid19/tabbar/tabbar3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'myapp.dart';
import 'pages_mod/secondpage.dart';

class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory>
    with AutomaticKeepAliveClientMixin {
  bool bringMenu = false;

  final PageController categorySelector =
      PageController(initialPage: 0, keepPage: true);
  int currentPage = 0;
  int numPages = 2;

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < numPages; i++) {
      list.add(i == currentPage ? indicator(true) : indicator(false));
    }
    return list;
  }

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 18.0 : 12.0,
      width: isActive ? 18.0 : 12.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xff115173), //Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(35)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double aspectRatio = double.parse(
        (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height)
            .toStringAsFixed(1));
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Color(0xff022c43),
        appBar: AppBar(
          title: Text('COVID-19 WORLDVIEW'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () => Phoenix.rebirth(context))
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        drawer: Drawer(
          child: DrawerMenu(),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: aspectRatio == 0.6
                  ? MediaQuery.of(context).size.height * 0.04
                  : MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              //color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                'Click on view to know more',
                style: TextStyle(
                  color: Colors.cyan[50],
                  fontSize: MediaQuery.of(context).size.width * 0.065,
                ),
              ),
            ),
            SizedBox(
              height: aspectRatio == 0.6
                  ? MediaQuery.of(context).size.height * 0.03
                  : MediaQuery.of(context).size.height * 0.07,
            ),
            Container(
              //color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.6,
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: categorySelector,
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width * 0.6,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Image.asset(
                          'assets/images/WorldMap.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      //Text(
                      //  'WORLD',
                      //  style: TextStyle(
                      //    fontSize: MediaQuery.of(context).size.width * 0.08,
                      //  ),
                      //),
                      SizedBox(
                        height: aspectRatio == 0.6
                            ? MediaQuery.of(context).size.height * 0.04
                            : MediaQuery.of(context).size.height * 0.06,
                      ),
                      //Text(
                      //  'WORLD ',textAlign: TextAlign.center,style: TextStyle(color: Colors.tealAccent,fontSize: MediaQuery.of(context).size.width * 0.1,
                      //  ),
                      //),
                      //SizedBox(
                      //  height: aspectRatio == 0.6? MediaQuery.of(context).size.height * 0.005: MediaQuery.of(context).size.height * 0.04,
                      //),
                      Text(
                        'See COVID-19\'s impact around the world ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                      SizedBox(
                        height: aspectRatio == 0.6
                            ? MediaQuery.of(context).size.height * 0.04
                            : MediaQuery.of(context).size.height * 0.06,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: RaisedButton(
                          child: Text(
                            'VIEW',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.1,
                            ),
                          ),
                          color: Color(0xff14ffec),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                              side: BorderSide(color: Colors.cyan[100])),
                          onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => FirstPage(),
                            ),
                          ),
                          //Navigator.push(context,PageRouteBuilder(pageBuilder: (context, animation1, animation2) => MyApp(),),),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width * 0.6,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Image.asset('assets/images/India.png'),
                      ),
                      SizedBox(
                        height: aspectRatio == 0.6
                            ? MediaQuery.of(context).size.height * 0.04
                            : MediaQuery.of(context).size.height * 0.06,
                      ),
                      //Text(
                      //  'INDIA',
                      //  textAlign: TextAlign.center,
                      //  style: TextStyle(
                      //    color: Colors.tealAccent,
                      //    fontSize: MediaQuery.of(context).size.width * 0.1,
                      //  ),
                      //),
                      //SizedBox(
                      //  height: aspectRatio == 0.6
                      //      ? MediaQuery.of(context).size.height * 0.005
                      //      : MediaQuery.of(context).size.height * 0.04,
                      //),
                      Text(
                        'See the statistics of COVID-19 in India',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      SizedBox(
                        height: aspectRatio == 0.6
                            ? MediaQuery.of(context).size.height * 0.04
                            : MediaQuery.of(context).size.height * 0.06,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: RaisedButton(
                          child: Text(
                            'VIEW',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.1,
                            ),
                          ),
                          color: Color(0xff14ffec),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                              side: BorderSide(color: Colors.cyan[100])),
                          onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SecondPage(),
                            ),
                          ),
                          //Navigator.push(context,PageRouteBuilder(pageBuilder: (context, animation1, animation2) => MyApp(),),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  //color: Colors.green,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buildPageIndicator(),
                      ),
                    ],
                  ),
                ),
                currentPage != numPages - 1
                    ? Container(
                        //color: Colors.red,
                        alignment: FractionalOffset.centerRight,
                        child: FlatButton(
                          onPressed: () {
                            categorySelector.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                      )
                    : Container(
                        alignment: FractionalOffset.centerLeft,
                        child: FlatButton(
                          onPressed: () {
                            categorySelector.previousPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
