import 'package:covid19/countryentrypage.dart';
import 'package:covid19/pages/Loading.dart';
import 'package:covid19/widgets/selectedCountry.dart';
import 'package:flutter/material.dart';

import 'apiresources/apiTemplate2.dart';

class CountryDetails extends StatefulWidget {
  var countryMaxDetails, countryStackIndex;

  CountryDetails(this.countryMaxDetails, this.countryStackIndex);
  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails>
    with AutomaticKeepAliveClientMixin<CountryDetails> {
  Future<Scaffold> getData3() {
    String s = widget.countryStackIndex;
    var data3 = fetch2(
      'https://corona.lmao.ninja/v2/historical/' + widget.countryStackIndex,
      30,
      1,
      1,
      'CountryDetails$s',
      60,
      widget.countryMaxDetails,
    );
    print('verify2' + 'CountryDetails$s');
    return data3;
  }

  @override
  Widget build(BuildContext context) {
    return
        //MaterialApp(
        //  debugShowCheckedModeBanner: false,
        //  home: Scaffold(
        //    backgroundColor: Color(0xff202f4e),
        //    appBar: AppBar(
        //      title: Text('PAGE 3'),
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
      future: getData3(),
      //    ),
      //  ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
