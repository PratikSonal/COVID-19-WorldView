import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkIndia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height * 0.07;
    double w = MediaQuery.of(context).size.height * 0.95;

    return Container(
      child: Column(children: <Widget>[
        redirectPage(
            'MINISTRY OF HEALTHCARE', 'https://www.mohfw.gov.in/', h, w),
        redirectPage('DONATE (PMCARES)',
            'https://www.pmindia.gov.in/en/?query', h, w),
        redirectPage(
            'WHO REPORTS ON INDIA',
            'https://www.who.int/india/emergencies/india-situation-report',
            h,
            w),
        redirectPage(
            'NEWS HEADLINES', 'https://www.india.gov.in/news_lists?a878774607', h, w),
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
      //color: Color(0xff233656),
      color: Color(0xff022c43),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.cyan[200],
                fontWeight: FontWeight.bold,
                fontSize: width * 0.025),
          )
        ],
      ),
    ),
  );
}
