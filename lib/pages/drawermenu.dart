import 'package:covid19/pages/about.dart';
import 'package:covid19/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    double aspectRatio = double.parse(
        (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height)
            .toStringAsFixed(1));
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              color: Color(0xff18FFFF),
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              //width: 100,
              child: Center(
                child: Container(
                  child: Image.asset('assets/images/Logo.png'),
                  height: MediaQuery.of(context).size.width * 0.35,
                ),
              ),
            ),
          ],
        ),
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              //color: Color(0xff212121),
              color: Colors.black,
            ),
            Column(
              children: <Widget>[
                //SizedBox(
                //  height: MediaQuery.of(context).size.height * 0.05,
                //),
                Divider(
                  color: Colors.transparent,
                ),
                ListTile(
                  title: Text(
                    'ABOUT',
                    style: TextStyle(
                        color: Color(0xff14ffec),
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
                Divider(
                  color: Colors.transparent,
                ),
                ListTile(
                  title: Text(
                    'SOURCE CODE',
                    style: TextStyle(
                        color: Color(0xff14ffec),
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: () => launch(
                      'https://github.com/PratikSonal/COVID-19-WorldView'),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                SizedBox(
                  height: aspectRatio == 0.6
                      ? MediaQuery.of(context).size.height * 0.4
                      : MediaQuery.of(context).size.height * 0.5,
                ),
                Center(
                  child: Text(
                    'Version  ' + SplashDataState.currentVersion.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
