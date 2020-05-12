import 'package:covid19/apiresources/apiTemplate.dart';
import 'package:covid19/pages/loading.dart';
import 'package:flutter/material.dart';

class CountryLoadingPage extends StatefulWidget {
  @override
  _CountryLoadingPageState createState() => _CountryLoadingPageState();
}

class _CountryLoadingPageState extends State<CountryLoadingPage>
    with AutomaticKeepAliveClientMixin<CountryLoadingPage> {
  Future<Scaffold> getData2() {
    var data2 = fetch('http://corona.lmao.ninja/v2/countries', 30, 5, 0,
        'CountryLoadingPage', 5, 2);
    return data2;
  }

  @override
  Widget build(BuildContext context) {
    return
        //MaterialApp(
        //  debugShowCheckedModeBanner: false,
        //  home: Scaffold(
        //    backgroundColor: Color(0xff202f4e),
        //    appBar: AppBar(
        //      title: Text('PAGE 2'),
        //      backgroundColor: Color(0xff233656),
        //    ),
        //   body:
        FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          print('Loading...');
          return LoadingPage();
        }
        return snapshot.data;
      },
      future: getData2(),
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
