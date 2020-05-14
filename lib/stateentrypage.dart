import 'package:covid19/apiresources/apiTemplateIndia.dart';
import 'package:covid19/pages/loading.dart';
import 'package:flutter/material.dart';

class StateLoadingPage extends StatefulWidget {
  @override
  _StateLoadingPageState createState() => _StateLoadingPageState();
}

class _StateLoadingPageState extends State<StateLoadingPage>
    with AutomaticKeepAliveClientMixin<StateLoadingPage> {
  Future<Scaffold> getData2() {
    var data2 = fetchIndia(30, 1, 10, 'India', 15, 2);
    return data2;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          print('Loading...');
          return LoadingPage();
        }
        return snapshot.data;
      },
      future: getData2(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
