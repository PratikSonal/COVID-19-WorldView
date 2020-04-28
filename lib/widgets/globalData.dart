import 'package:flutter/material.dart';

class GlobalData extends StatelessWidget {

  final Map worldData;
  GlobalData({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Statistics(
            title: 'CONFIRMED',
            count: worldData['cases'].toString(),
            c1: Colors.lightBlue[100],
            c2: Colors.lightBlueAccent,
          ),
          Statistics(
            title: '  ACTIVE  ',
            count: worldData['active'].toString(),
            c1: Colors.yellow[100] ,
            c2: Colors.yellowAccent[400] ,
          ),
          Statistics(
            title: 'RECOVERED',
            count: worldData['recovered'].toString(),
            c1: Colors.lightGreenAccent[100],
            c2: Colors.lightGreenAccent[400],
          ),
          Statistics(
            title: ' DEATHS ',
            count: worldData['deaths'].toString(),
            c1: Colors.redAccent[100] ,
            c2: Colors.red,
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

  const Statistics(
      {Key key, this.c1, this.c2, this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width,
        displayHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        margin: EdgeInsets.all(1),
        height: displayWidth * 0.27 ,
        width: displayWidth * 0.9 ,
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
                      fontWeight: FontWeight.w200,
                      fontSize: displayWidth * 0.13,
                      color: c1),
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: displayWidth * 0.05,
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
