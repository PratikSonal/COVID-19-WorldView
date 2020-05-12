import 'package:covid19/pages_india/statelist.dart';
import 'package:covid19/widgets/selectedCountry.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SelectedStateDetails extends StatefulWidget {
  var data1, data2, data3;

  SelectedStateDetails(this.data1, this.data2, this.data3);

  @override
  SelectedStateDetailsState createState() => SelectedStateDetailsState();
}

class SelectedStateDetailsState extends State<SelectedStateDetails>
    with SingleTickerProviderStateMixin {
  List data1;
  var data2, data3;

  static int counter = 0;

  String s = StatePageState.stateName; //'Odisha';
  String sc = StatePageState.stateCode;

  TabController tabControllerState;

  fetchIndiaStateDist() async {
    //http.Response response = await http.get('https://api.covid19india.org/v2/state_district_wise.json');
    //http.Response response2 =await http.get('https://api.covid19india.org/zones.json');
    //http.Response response3 =await http.get('https://api.covid19india.org/data.json');
    setState(() {
      data1 = widget.data1; //json.decode(response.body);
      data2 = widget.data2; //json.decode(response2.body);
      data3 = widget.data3; //json.decode(response3.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabControllerState = TabController(length: 2, vsync: this);
    fetchIndiaStateDist();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double aspectRatio = double.parse(
        (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height)
            .toStringAsFixed(1));
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.01,
          right: MediaQuery.of(context).size.width * 0.01,
          top: 0,
          bottom: 0),
      child: s == null
          ? Container(
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02,
                    top: 0,
                    bottom: 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                        height: aspectRatio == 0.6 ? size * 0.4 : size * 0.7),
                    Center(
                      child: Text(
                        'NO STATE SELECTED',
                        style: TextStyle(
                            color: Colors.cyan[100],
                            fontSize:
                                MediaQuery.of(context).size.width * 0.065),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Center(
                      child: Text(
                        'Select a state from the country list and see additional details',
                        style: TextStyle(
                            fontSize: size * 0.04, color: Colors.cyan[100]),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width * 0.25,
                          width: MediaQuery.of(context).size.width * 0.4,
                          //child: Image(
                          //    image: CachedNetworkImageProvider(
                          //  widget.countryMaxDetail['countryInfo']['flag'],
                          //)),
                          child: Image.asset(
                              'assets/images/' + sc.toString() + '.png'),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.25,
                          width: MediaQuery.of(context).size.width * 0.5,
                          alignment: Alignment.center,
                          child: Text(
                            Ttext(s),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: customText2(
                                  s, MediaQuery.of(context).size.width),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size * 0.02,
                      right: size * 0.02,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: size * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'CONFIRMED',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.cyan[100]),
                            ),
                            Text(
                              widget.data3['statewise'][getSync2(data3, s)]
                                      ['confirmed']
                                  .toString(),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.cyan[100]),
                            ),
                          ],
                        ),
                        SizedBox(height: size * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'ACTIVE',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.cyan[100]),
                            ),
                            Text(
                              widget.data3['statewise'][getSync2(data3, s)]
                                      ['active']
                                  .toString(),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.cyan[100]),
                            ),
                          ],
                        ),
                        SizedBox(height: size * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'RECOVERED',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.cyan[100]),
                            ),
                            Text(
                              widget.data3['statewise'][getSync2(data3, s)]
                                      ['recovered']
                                  .toString(),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.cyan[100]),
                            ),
                          ],
                        ),
                        SizedBox(height: size * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'DEATHS',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.cyan[100]),
                            ),
                            Text(
                              widget.data3['statewise'][getSync2(data3, s)]
                                      ['deaths']
                                  .toString(),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.cyan[100]),
                            ),
                          ],
                        ),
                        SizedBox(height: size * 0.055),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xff022c43),
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: TabBar(
                      controller: tabControllerState,
                      tabs: <Widget>[
                        Container(
                          child: Text('DISTRICT DETAILS',
                              style: TextStyle(color: Color(0xff14ffec))),
                        ),
                        Container(
                          child: Text('ZONES',
                              style: TextStyle(color: Color(0xff14ffec))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: TabBarView(
                      controller: tabControllerState,
                      children: <Widget>[
                        Container(
                          color: Color(0xff053f5e),
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: data1 == null
                                ? Center(child: CircularProgressIndicator())
                                : Column(
                                    children: <Widget>[
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                              ),
                                              Container(
                                                  child: Text(
                                                'DISTRICT',
                                                style: TextStyle(
                                                    color: Colors.cyan[100],
                                                    fontSize: size * 0.03),
                                              )),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.07,
                                              ),
                                              Text('CONFIRMED',
                                                  style: TextStyle(
                                                      color: Colors.cyan[100],
                                                      fontSize: size * 0.03)),
                                              Text('ACTIVE',
                                                  style: TextStyle(
                                                      color: Colors.cyan[100],
                                                      fontSize: size * 0.03)),
                                              Text('RECOVERED',
                                                  style: TextStyle(
                                                      color: Colors.cyan[100],
                                                      fontSize: size * 0.03)),
                                              Text('DEATHS',
                                                  style: TextStyle(
                                                      color: Colors.cyan[100],
                                                      fontSize: size * 0.03)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.46, //0.307,
                                        child: ListView.builder(
                                          itemCount: getDistrictCount(data1, s),
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color: Colors.cyan[100],
                                              child: Container(
                                                height: 55,
                                                child:
                                                    //Text(data1[getDistrictIndex(data1, s)]['districtData'][index].toString()),
                                                    Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      color: Color(0xff115173),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      child: Center(
                                                          child: Text(
                                                        data1[getDistrictIndex(
                                                                        data1,
                                                                        s)][
                                                                    'districtData']
                                                                [
                                                                index]['district']
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                    ),
                                                    Container(
                                                      color: Color(0xff115173),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.175,
                                                      child: Center(
                                                        child: Text(
                                                          data1[getDistrictIndex(
                                                                          data1,
                                                                          s)][
                                                                      'districtData']
                                                                  [
                                                                  index]['confirmed']
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      color: Color(0xff115173),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.16,
                                                      child: Center(
                                                        child: Text(
                                                          data1[getDistrictIndex(
                                                                          data1,
                                                                          s)][
                                                                      'districtData']
                                                                  [
                                                                  index]['active']
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      color: Color(0xff115173),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.16,
                                                      child: Center(
                                                        child: Text(
                                                          data1[getDistrictIndex(
                                                                          data1,
                                                                          s)][
                                                                      'districtData']
                                                                  [
                                                                  index]['recovered']
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      color: Color(0xff115173),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.16,
                                                      child: Center(
                                                        child: Text(
                                                          data1[getDistrictIndex(
                                                                          data1,
                                                                          s)][
                                                                      'districtData']
                                                                  [
                                                                  index]['deceased']
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        Container(
                          color: Color(0xff053f5e),
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: data2 == null
                                ? Center(child: CircularProgressIndicator())
                                : Column(
                                    children: <Widget>[
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(
                                                'DISTRICT',
                                                style: TextStyle(
                                                    fontSize: size * 0.035,
                                                    color: Colors.cyan[100]),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                              ),
                                              Text(
                                                'ZONE',
                                                style: TextStyle(
                                                    fontSize: size * 0.035,
                                                    color: Colors.cyan[100]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.46,
                                        child: ListView(
                                          children: addData(data2, s),
                                        ),
                                        /*
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    addAutomaticKeepAlives: true,
                                    itemCount: zoneCount(data2, s),
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: Container(
                                          height: 55,
                                          //child: Text(data2['zones'][increment(zoneIndex(data2, s))].toString()),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                child: Center(
                                                  child: Text(data2['zones'][
                                                              increment(zoneIndex(
                                                                  data2,
                                                                  s))] //zoneIndex(data2, s)
                                                          ['district']
                                                      .toString()),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                child: Center(
                                                  child: Text(data2['zones'][
                                                          increment(zoneIndex(
                                                              data2, s))]['zone']
                                                      .toString()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  */
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  int increment(int x) {
    x = x + counter;
    counter += 1;
    print('value of zoneCount is $x');
    return x;
  }

  List<Widget> addData(var data2, String s) {
    List<Widget> list = new List();
    for (int i = zoneIndex(data2, s);
        i <= zoneCount(data2, s) + zoneIndex(data2, s);
        i++) {
      list.add(
        new Card(
          color: Color(0xff115173),
          child: Container(
            height: 55,
            //child: Text(data2['zones'][increment(zoneIndex(data2, s))].toString()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  color: Color(0xff115173),
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Center(
                    child: Text(
                      data2['zones'][i]['district'].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Container(
                  color: Color(0xff115173),
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Center(
                    child: Text(
                      data2['zones'][i]['zone'].toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  color: returnColor(data2['zones'][i]['zone'].toString()),
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return list;
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
      count += 1;
    }
  }
  print('zone count for $s' + ' is $count');
  return count - 1;
}

zoneIndex(Map data, String s) {
  int x;
  for (int i = 0; i <= data['zones'].length - 1; i++) {
    if (data['zones'][i]['state'].toString() == s) {
      x = i;
      break;
    }
  }
  //print('start of $s' + ' is at $x');
  return x;
}

getSync2(var data2, String s) {
  for (int i = 0; i <= data2['statewise'].length - 1; i++) {
    if (s == data2['statewise'][i]['state']) {
      print(s + data2['statewise'][i]['state'].toString());
      return i;
    }
  }
}

returnColor(String s) {
  if (s == 'Green') {
    return Color(0xff0cfe00);
  } else if (s == 'Orange') {
    return Colors.amber[900];
  } else if (s == 'Red') {
    return Color(0xffff0000);
  }
}
