import 'package:flutter/material.dart';

class IndiaData extends StatelessWidget {
  final Map indiaData;
  IndiaData({Key key, this.indiaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Statistics(
            title: 'CONFIRMED',
            count: indiaData['statewise'][0]['confirmed'].toString(),
            c1: Colors.cyan[100],
            c2: Colors.lightBlueAccent,
          ),
          Statistics(
            title: '  ACTIVE  ',
            count: indiaData['statewise'][0]['active'].toString(),
            c1: Colors.cyan[100],
            c2: Colors.yellowAccent[400],
          ),
          Statistics(
            title: 'RECOVERED',
            count: indiaData['statewise'][0]['recovered'].toString(),
            c1: Colors.cyan[100],
            c2: Colors.lightGreenAccent[400],
          ),
          Statistics(
            title: ' DEATHS ',
            count: indiaData['statewise'][0]['deaths'].toString(),
            c1: Colors.cyan[100],
            c2: Colors.deepOrange,
          ),
        ],
      ),
    );
  }
}

class Statistics extends StatelessWidget {
  final Color c1;
  final Color c2;
  final String title;
  final String count;

  const Statistics({Key key, this.c1, this.c2, this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width,
        displayHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        margin: EdgeInsets.all(1),
        height: displayWidth * 0.27,
        width: displayWidth * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  count,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: displayWidth * 0.13,
                      color: c1),
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: displayWidth * 0.07,
                      color: c2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
