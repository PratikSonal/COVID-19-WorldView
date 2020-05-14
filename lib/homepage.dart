import 'package:covid19/apiresources/apiTemplate.dart';
import 'package:covid19/pages/loading.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  static Future<Scaffold> getData() {
    var data1 =
        fetch('http://corona.lmao.ninja/v2/all', 30, 1, 0, 'homepage', 5, 1);
    return data1;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
      } ,
      child: FutureBuilder(
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
      ),
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
