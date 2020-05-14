import 'dart:async';
import 'dart:io';
import 'package:covid19/SelectCategory.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:covid19/myapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'pages/error.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashData(),
    );
  }
}

class SplashData extends StatefulWidget {
  @override
  SplashDataState createState() => SplashDataState();
}

class SplashDataState extends State<SplashData> {
  var doc;
  static var currentVersion;
  var latestVersion;
  List links;
  List<Map<String, String>> linkMap;
  bool isVisible = false;

  int callBack = 0;
  bool animateTop = false;

  String url(var x) {
    return 'https://github.com/PratikSonal/COVID-19-WorldView/releases/download/' +
        x.toString() +
        '/app.apk';
  }

  fetchData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currentVersion = packageInfo.version;
    print('Current version is ' + currentVersion);
    try {
      final Response response = await get(
              'https://github.com/PratikSonal/COVID-19-WorldView/releases/latest')
          .timeout(Duration(seconds: 30));

      setState(() {
        if (response.statusCode == 200) {
          var document = parse(response.body);
          links = document.querySelectorAll('div > ul > li > a > span ');
          linkMap = [];
          for (var link in links) {
            linkMap.add({
              'title': link.text,
            });
          }
          var dec = jsonDecode(json.encode(linkMap));
          latestVersion = dec[6]['title'];
          print('Latest version is ' + latestVersion);
          print(linkMap.toString());
          if (latestVersion != currentVersion) {
            isVisible = true;
            callBack = 1;
          } else {
            print('Latest update installed');
            //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp()),);
            callBack = 2;
            Future.delayed(Duration(milliseconds: 1200), () {
              setState(() {
                animateTop = true;
              });
              //Navigator.pushReplacement(
              //  context,
              //  MaterialPageRoute(builder: (context) => MyApp()),
              //);
            });

            Future.delayed(Duration(milliseconds: 1650), () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 220),
                      transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secAnimation,
                          Widget child) {
                        animation:
                        CurvedAnimation(parent: animation, curve: Curves.ease);
                        return ScaleTransition(
                          alignment: Alignment.center,
                          scale: animation,
                          child: child,
                        );
                      },
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secAnimation) {
                        return SelectCategory();
                      }));
            });
          }
        } else {
          print('Executed');
          //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp()),);
          callBack = 2;
          Future.delayed(Duration(milliseconds: 1200), () {
            setState(() {
              animateTop = true;
            });
            //Navigator.pushReplacement(
            //  context,
            //  MaterialPageRoute(builder: (context) => MyApp()),
            //);
          });

          Future.delayed(Duration(milliseconds: 1650), () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 220),
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secAnimation,
                        Widget child) {
                      animation:
                      CurvedAnimation(parent: animation, curve: Curves.ease);
                      return ScaleTransition(
                        alignment: Alignment.center,
                        scale: animation,
                        child: child,
                      );
                    },
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secAnimation) {
                      return SelectCategory();
                    }));
          });
        }
      });
    } on TimeoutException catch (e) {
      print('timeout');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashTimeout()),
      );
    } on SocketException catch (e) {
      print('networkerror');
      print('timeout');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashSocket()),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double containerSize = deviceWidth * 0.4;

    double aspectRatio = double.parse(
        (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height)
            .toStringAsFixed(1));
    print('Aspect ratio is ' + aspectRatio.toString());

    return Scaffold(
      backgroundColor: Color(0xff022c43),
      //backgroundColor: Color(0xff212121),
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
            bottom: callBack == 2
                ? (animateTop == true
                    ? MediaQuery.of(context).size.height * 1 //0.85
                    : (aspectRatio == 0.6
                        ? MediaQuery.of(context).size.height * 0.49
                        : MediaQuery.of(context).size.height * 0.49))
                : (aspectRatio == 0.6
                    ? MediaQuery.of(context).size.height * 0.34
                    : MediaQuery.of(context).size.height * 0.38),
            right: MediaQuery.of(context).size.width * 0.15,
            duration: Duration(milliseconds: animateTop == true ? 500 : 1000),
            curve: Curves.easeOut,
            child: Text(
              'COVID-19 \nWORLDVIEW',
              style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: MediaQuery.of(context).size.width * 0.08),
            ),
          ),
          Positioned(
            top: aspectRatio == 0.6
                ? MediaQuery.of(context).size.height * 0.55
                : MediaQuery.of(context).size.height * 0.52,
            right: MediaQuery.of(context).size.width * 0.02,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.7,
              color: Color(0xff022c43),
            ),
          ),
          AnimatedPositioned(
            top: animateTop == true
                ? MediaQuery.of(context).size.height * -0.12 //0.05
                : aspectRatio == 0.6
                    ? MediaQuery.of(context).size.height * 0.38
                    : MediaQuery.of(context).size.height * 0.4,
            left: callBack == 2
                ? MediaQuery.of(context).size.width * 0.08
                : MediaQuery.of(context).size.width * 0.3,
            duration: Duration(milliseconds: animateTop == true ? 500 : 800),
            curve: Curves.easeOut,
            child: Center(
              child: AnimatedContainer(
                //height: MediaQuery.of(context).size.width * 0.4,
                //width: MediaQuery.of(context).size.width * 0.4,
                height: callBack == 2 ? containerSize * 0.6 : containerSize,
                width: callBack == 2 ? containerSize * 0.6 : containerSize,
                duration: (Duration(seconds: 1)),
                child: Image.asset('assets/images/Logo.png'),
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: callBack == 2 ? false : true,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                child: SpinKitDualRing(
                  color: Colors.cyan[100],
                  size: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: animateTop == true
                ? MediaQuery.of(context).size.height * -0.03
                : MediaQuery.of(context).size.height * 0.03,
            left: MediaQuery.of(context).size.width * 0.38,
            child:
                //Center(
                //child: Column(
                //children: <Widget>[
                //SizedBox(
                //  height: MediaQuery.of(context).size.height * 0.95,
                //),
                Container(
              child: currentVersion == null
                  ? SizedBox(
                      height: 0,
                    )
                  : Text(
                      'Version ' + currentVersion,
                      style: TextStyle(
                        color: Colors.cyan[100],
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
            ),
            //],
            //),
            //),
          ),
          Center(
            child: Visibility(
              visible: isVisible,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black54,
              ),
            ),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.95,
              width: MediaQuery.of(context).size.width * 0.95,
              child: callBack == 0
                  ? Container()
                  : callBack == 1
                      ? CupertinoAlertDialog(
                          title: Text(
                            'Update Available',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.06),
                          ),
                          content: Text(
                            'Version ' +
                                latestVersion +
                                ' is available. Download the latest release from GitHub?',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyApp()),);
                                  setState(() {
                                    isVisible = false;
                                    callBack = 2;
                                  });
                                  Future.delayed(Duration(milliseconds: 1200),
                                      () {
                                    setState(() {
                                      animateTop = true;
                                    });
                                  });

                                  Future.delayed(Duration(milliseconds: 1650),
                                      () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            transitionDuration:
                                                Duration(milliseconds: 220),
                                            transitionsBuilder: (BuildContext
                                                    context,
                                                Animation<double> animation,
                                                Animation<double> secAnimation,
                                                Widget child) {
                                              animation:
                                              CurvedAnimation(
                                                  parent: animation,
                                                  curve: Curves.ease);
                                              return ScaleTransition(
                                                alignment: Alignment.center,
                                                scale: animation,
                                                child: child,
                                              );
                                            },
                                            pageBuilder: (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double>
                                                    secAnimation) {
                                              return SelectCategory();
                                            }));
                                  });
                                },
                                child: Text(
                                  'Later',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                )),
                            FlatButton(
                                onPressed: () {
                                  launch(url(latestVersion));
                                },
                                child: Text(
                                  'Download',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                )),
                          ],
                        )
                      : SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashTimeout extends StatefulWidget {
  @override
  _SplashTimeoutState createState() => _SplashTimeoutState();
}

class _SplashTimeoutState extends State<SplashTimeout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff022c43),
      body: ErrorPageSplash('Connection timed out', 'Please try again'),
    );
  }
}

class SplashSocket extends StatefulWidget {
  @override
  _SplashSocketState createState() => _SplashSocketState();
}

class _SplashSocketState extends State<SplashSocket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff022c43),
      body: ErrorPageSplash(
          'Network error', 'Please connect to a network and try again'),
    );
  }
}

class ErrorPageSplash extends StatefulWidget {
  String a, b;
  ErrorPageSplash(this.a, this.b);
  @override
  _ErrorPageSplashState createState() => _ErrorPageSplashState();
}

class _ErrorPageSplashState extends State<ErrorPageSplash> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          Center(
            child: Icon(
              Icons.error,
              size: MediaQuery.of(context).size.width * 0.15,
              color: Colors.cyan[100],
            ),
          ),
          Center(
            child: Text(
              widget.a,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.07,
                color: Colors.cyan[100],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.006,
          ),
          Center(
            child: Text(
              widget.b,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: Colors.cyan[100],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.25,
            child: RaisedButton(
              child: Text(
                'Retry',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
              color: Color(0xff14ffec),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: Colors.cyan[100])),
              onPressed: () => Phoenix.rebirth(context),
            ),
          ),
        ],
      ),
    );
  }
}
