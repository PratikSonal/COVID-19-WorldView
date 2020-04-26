import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height * 0.07;
    double w = MediaQuery.of(context).size.height * 0.95;

    return Container(
      child: Column(children: <Widget>[
        redirectPage(
            'LEARN MORE',
            'https://www.who.int/emergencies/diseases/novel-coronavirus-2019',
            h,
            w),
        redirectPage(
            'DONATE',
            'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate',
            h,
            w),
        redirectPage(
            'VIEW MORE STATS', 'https://coronavirus.jhu.edu/map.html', h, w),
        redirectPage(
            'MYTHBUSTERS',
            'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters',
            h,
            w),
      ]),
    );
  }
}

Widget redirectPage(String title, String link, double height, double width) {
  return GestureDetector(
    onTap: () {
      launch(link);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      height: height,
      width: width,
      color: Color(0xff233656),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: width*0.025 ),
          )
        ],
      ),
    ),
  );
}
