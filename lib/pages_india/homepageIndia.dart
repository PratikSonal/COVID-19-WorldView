import 'dart:convert';
import 'package:covid19/tabbar/tabbar1.dart';
import 'package:covid19/tabbar/tabbar3.dart';
import 'package:covid19/widgets/link.dart';
import 'package:covid19/widgets_india/indiaData.dart';
import 'package:covid19/widgets_india/linkindia.dart';
import 'package:covid19/widgets_india/pieChartIndia.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

import '../myapp.dart';

class IndiaPage extends StatefulWidget {
  var data;
  IndiaPage(this.data);
  @override
  _IndiaPageState createState() => _IndiaPageState();
}

class _IndiaPageState extends State<IndiaPage> {
  var indiaData;

  fetchIndiaData() async {
    //http.Response response =
    //    await http.get('https://api.covid19india.org/data.json');
    setState(() {
      //indiaData = json.decode(response.body);
      indiaData = widget.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchIndiaData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.99,
        child: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              (indiaData == null)
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
                            'INDIA AT GLANCE',
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
                          (indiaData == null)
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
                                    PieChartIndia(indiaData),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.80,
                                      width: MediaQuery.of(context).size.width *
                                          0.80,
                                      child: Center(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
                                          child: Image.asset(
                                            'assets/images/India.png',
                                            height: 100,
                                            width: 100,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  IndiaData(
                                    indiaData: indiaData,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          indiaData == null ? SizedBox() : LinkIndia(),
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
    )
        //,
        //)
        ;
    ;
  }
}
