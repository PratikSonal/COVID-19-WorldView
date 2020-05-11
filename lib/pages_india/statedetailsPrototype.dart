import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PrototypeSelectedStateDetails extends StatefulWidget {
  @override
  _PrototypeSelectedStateDetailsState createState() => _PrototypeSelectedStateDetailsState();
}

class _PrototypeSelectedStateDetailsState extends State<PrototypeSelectedStateDetails> {
  List data1;
  var data2;

  String s = 'Odisha' ;

  fetchIndiaStateDist() async {
    http.Response response = await http
        .get('https://api.covid19india.org/v2/state_district_wise.json');
    http.Response response2 =
        await http.get('https://api.covid19india.org/zones.json');
    setState(() {
      data1 = json.decode(response.body);
      data2 = json.decode(response2.body);
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
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(2),
              child: data1 == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: getDistrictCount(data1, s),
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            height: 60,
                            child: Text(
                                data1[getDistrictIndex(data1, s)]
                                        ['districtData'][index]
                                    .toString()),
                          ),
                        );
                      },
                    ),
            ),
          ),
          Container(
            height: 300,
            child: Padding(
              padding: EdgeInsets.all(2),
              child: data2 == null
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: zoneCount(data2, s),
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            child: Text(data2['zones']
                                    [increment(zoneIndex(data2, s))]
                                .toString()),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

getDistrictIndex(List data, String s) {
  for (int i = 0; i <= data.length; i++) {
    if (data[i]['state'].toString() == s) {
      return i;
    }
  }
}

getDistrictCount(List data, String s) {
  for (int i = 0; i <= data.length; i++) {
    if (data[i]['state'].toString() == s) {
      return data[i]['districtData'].length;
    }
  }
}

zoneCount(Map data, String s) {
  int count = 0;
  for (int i = 0; i <= data['zones'].length - 1; i++) {
    if (data['zones'][i]['state'].toString() == s) {
      count++;
    }
  }
  print('zone count for $s' + ' is $count');
  return count;
}

zoneIndex(Map data, String s) {
  for (int i = 0; i <= data['zones'].length - 1; i++) {
    if (data['zones'][i]['state'].toString() == s) {
      return i;
    }
  }
}

int i = -1;

increment(int x) {
  x = x + i + 1;
  i += 1;
  return i;
}
