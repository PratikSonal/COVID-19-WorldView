import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondTab extends StatefulWidget {
  @override
  _SecondTabState createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  var indiaStateDistData, data2, data3;

  fetchIndiaStateDist() async {
    http.Response response = await http
        .get('https://api.covid19india.org/v2/state_district_wise.json');
    http.Response response2 =
        await http.get('https://api.covid19india.org/data.json');
    http.Response response3 =
        await http.get('https://api.covid19india.org/zones.json');
    setState(() {
      indiaStateDistData = json.decode(response.body);
      data2 = json.decode(response2.body);
      data3 = json.decode(response3.body);
      print(indiaStateDistData.toString());
      print(data2.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchIndiaStateDist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.amber,
      body: //Container(
          //child: Center(
          //    child: Text(
          //'Empty, for now :)',
          //style: TextStyle(fontSize: 30),
          //)
          //)
          //),
          Column(
        children: <Widget>[
          Container(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (indiaStateDistData == null || data2 == null)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: indiaStateDistData.length ,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            height: 30,
                            child: Column(
                              children: <Widget>[
                                Text(indiaStateDistData[index]['state'] +
                                    data2['statewise'][getSync(
                                            indiaStateDistData, data2, index)]
                                        ['active']),
                                //Text(indiaStateDistData[index]['districtData'][index].toString()),
                              ],
                            ),
                          ),
                        );
                      }),
            ),
          ),
          Container(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (indiaStateDistData == null || data2 == null)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: indiaStateDistData[0]['districtData'].length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            height: 60,
                            child: Column(
                              children: <Widget>[
                                Text(indiaStateDistData[0]['districtData']
                                        [index]
                                    .toString()),
                              ],
                            ),
                          ),
                        );
                      }),
            ),
          ),
          Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (indiaStateDistData == null ||
                      data2 == null ||
                      data3 == null)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount:
                          getZoneIndex(data3, 'Andaman and Nicobar Islands'),
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            height: 60,
                            child: Column(
                              children: <Widget>[
                                Text(data3['zones'][increment(-1)].toString()),
                              ],
                            ),
                          ),
                        );
                      }),
            ),
          ),
        ],
      ),
    );
  }
}

getSync(var indiaStateDistData, data2, var index) {
  for (int i = 0; i <= 37; i++) {
    if (indiaStateDistData[index]['state'] == data2['statewise'][i]['state']) {
      print(indiaStateDistData[index]['state'].toString() +
          data2['statewise'][i]['state'].toString());
      return i;
    }
  }
}

getZoneIndex(var data3, String s) {
  int c = 0;
  for (int i = 0; i <= data3.length; i++) {
    if (data3['zones'][i]['state'] == s) {
      c = c + 1;
    }
  }
  return c;
}

getZone(var data3, String s) {
  for (int i = 0; i <=  data3.length ; i++) {
    if (data3['zones'][i]['state'] == s) {
      print(data3['zones'][i].toString());
      return i;
    }
  }
}

getZoneIndex2(var data3, String s) {
  int c = 0;
  for (int i = 0; i <= data3.length ; i++) {
    if (data3['zones'][i]['state'] == s) {
      c = i;
      break;
    }
  }
  return c;
}

int y = 0;

increment(var x) {
  x = x + y + 1;
  y++;
  return x;
}
