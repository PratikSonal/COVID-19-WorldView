import 'package:covid19/apiresources/apiTemplateIndia.dart';
import 'package:covid19/pages/loading.dart';
import 'package:flutter/material.dart';

class HomePageIndia extends StatefulWidget {
  @override
  _HomePageIndiaState createState() => _HomePageIndiaState();
}

class _HomePageIndiaState extends State<HomePageIndia>
    with AutomaticKeepAliveClientMixin<HomePageIndia> {
  static Future<Scaffold> getData() {
    var data1 = fetchIndia(30, 1, 1, 'India', 15, 1);
    return data1;
  }

  @override
  Widget build(BuildContext context) {
    return
        //MaterialApp(
        //  debugShowCheckedModeBanner: false,
        //  home: Scaffold(
        //    backgroundColor: Color(0xff202f4e),
        //    appBar: AppBar(
        //      title: Text('PAGE 1'),
        //      backgroundColor: Color(0xff233656),
        //    ),
        //    body:
        FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          print('Loading...');
          return LoadingPage();
        }
        return snapshot.data;
      },
      future: getData(),
      //    ),
      //  ),
    );

    //body: FutureBuilder(
    //  builder: (BuildContext context, AsyncSnapshot snapshot) {
    //    return snapshot.data == null
    //        ? LoadingPage()
    //        : LoadedPage(snapshot.data);
    //  },
    //  future: api,
    //),
    //  ),
    //);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
