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
  _SplashDataState createState() => _SplashDataState();
}

class _SplashDataState extends State<SplashData> {
  var doc, currentVersion;
  var latestVersion;
  List links;
  List<Map<String, String>> linkMap;
  bool isVisible = false;
  //String versionNumber = '2.5.0';

  int callBack = 0;

  String url(var x) {
    return 'https://github.com/KejariwalAyush/NCOV-19/releases/download/' +
        x.toString() +
        '/app.apk';
  }

  fetchData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currentVersion = packageInfo.version;
    print(currentVersion);
    final Response response =
        await get('https://github.com/KejariwalAyush/NCOV-19/releases/latest');
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
        print(latestVersion);
        print(linkMap.toString());
        if (latestVersion != currentVersion) {
          isVisible = true;
          callBack = 1;
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
          callBack = 2;
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
        callBack = 2;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff022c43),
      //backgroundColor: Color(0xff212121),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Image.asset('assets/images/Logo.png'),
            ),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              child: SpinKitDualRing(
                color: Colors.cyan[100],
                size: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.95,
                ),
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
              ],
            ),
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
                                ' is available. Download the latest update from GitHub?',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                  );
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
