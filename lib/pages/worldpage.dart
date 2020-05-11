import 'package:covid19/countryentrypage.dart';
import 'package:covid19/widgets/globalData.dart';
import 'package:covid19/widgets/link.dart';
import 'package:covid19/widgets/pieChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WorldPage extends StatefulWidget {
  var data;

  WorldPage(this.data);
  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  @override
  Widget build(BuildContext context) {
    return
        //MaterialApp(
        //home: Scaffold(
        //body:
        Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.99,
        child: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              (widget.data == null)
                  ? Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.5,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.cyanAccent[100],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'WORLD AT GLANCE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.cyanAccent[100],
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.075),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          (widget.data == null)
                              ? Container(
                                  height: 200,
                                  width: 200,
                                  child: Center(
                                    child: SpinKitThreeBounce(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Stack(
                                  children: <Widget>[
                                    PieChartData(widget.data),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.80,
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      //child: Icon(
                                      //  FontAwesomeIcons.globeAmericas,
                                      //  color: Colors.white54,
                                      //  size:
                                      //      MediaQuery.of(context).size.width *
                                      //          0.55,
                                      //),
                                      child: Center(
                                        child: Container(
                                          height:
                                              MediaQuery.of(context).size.width *
                                                  0.6,
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.6,
                                          child: Image.asset(
                                            'assets/images/Earth.png',
                                            height: 100,
                                            width: 100,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  GlobalData(
                                    worldData: widget.data,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          widget.data == null ? SizedBox() : Link(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        //),
        //),
      ),
    );
  }
}
