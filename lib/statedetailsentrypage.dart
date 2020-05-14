import 'package:flutter/material.dart';

import 'apiresources/apiTemplateIndia.dart';
import 'pages/loading.dart';

class StateDetailsEntryPage extends StatefulWidget {
  @override
  _StateDetailsEntryPageState createState() => _StateDetailsEntryPageState();
}

class _StateDetailsEntryPageState extends State<StateDetailsEntryPage>
    with AutomaticKeepAliveClientMixin {
  Future<Scaffold> getData3() {
    var data3 = fetchIndia(30, 1, 10, 'India', 15, 3);
    return data3;
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
      future: getData3(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
