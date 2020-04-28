import 'package:flutter_spinkit/flutter_spinkit.dart';
import './widgets/selectedCountry.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './widgets/globalData.dart';
import './widgets/link.dart';
import './widgets/dynamicList.dart';
import './widgets/pieChart.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TextEditingController editingController = TextEditingController();
  List<charts.Series<Task, String>> seriesPieData;
  Map worldData, newData, countryMaxDetail;
  TextEditingController controller;
  TabController tabBarController;
  List countryData, suggestions;
  int newindex;
  String countryStackIndex;

  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  var stackBarData, countryStack;
  fetchHistory() async {
    countryStack = null;
    http.Response response = await http
        .get('https://corona.lmao.ninja/v2/historical/' + countryStackIndex);
    setState(() {
      stackBarData = json.decode(response.body);
      countryStack = stackBarData;
      print(countryStack);
    });
  }

  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData = json.decode(response.body);
      suggestions = countryData;
    });
  }

  generatePieData() async {
    http.Response resp = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      newData = json.decode(resp.body);
    });
  }

//  generateData() async {
//    http.Response resp = await http.get('https://corona.lmao.ninja/v2/all');
//    setState(() {
//      newData = json.decode(resp.body);
//      var pieData = [
//        Task('Active', (newData['active'] / newData['cases'] * 100),
//            Colors.yellowAccent
//            //Colors.blue
//            ),
//        Task('Recovered', (newData['recovered'] / newData['cases'] * 100),
//            Colors.lightGreenAccent[400]
//            //Colors.green
//            ),
//        Task('Deaths', (newData['deaths'] / newData['cases']) * 100,
//            Colors.deepOrangeAccent[400]
//            //Colors.red
//            ),
//      ];

//      seriesPieData.add(charts.Series(
//        data: pieData,
//        domainFn: (Task task, _) => task.task,
//        measureFn: (Task task, _) => task.taskvalue,
//        colorFn: (Task task, _) =>
//            charts.ColorUtil.fromDartColor(task.colorval),
//        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
//        id: 'Chart',
//      ));
//    });
//  }

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(
      length: 3,
      vsync: this,
    );
    seriesPieData = List<charts.Series<Task, String>>();
    fetchWorldWideData();
    generatePieData();
    //generateData();
    fetchCountryData();
    fetchHistory();
  }

  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  filterSearchResults(String query) {
    setState(() {
      suggestions = query.isEmpty
          ? countryData
          : countryData
              .where((element) => element['country']
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()))
              .toList();
    });
  }

  refreshApp() {
    fetchWorldWideData();
    generatePieData();
    fetchCountryData();
    filterSearchResults('');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Arimo'),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color(0xff202f4e),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: AppBar(
              title: Text(
                'COVID-19  WORLDVIEW',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      refreshApp();
                    })
              ],
              centerTitle: true,
              backgroundColor: Color(0xff233656),
              //backgroundColor: Color(0xff1976d2),
              //backgroundColor: Color(0xff308e1c),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(30),
                child: Container(
                  height: 30,
                  child: TabBar(
                    labelPadding: EdgeInsets.only(bottom: 10),
                    controller: tabBarController,
                    //indicatorColor: Color(0xff308e1c),
                    indicatorColor: Colors.lightBlueAccent,
                    tabs: [
                      Container(
                        alignment: Alignment.center,
                        height: 20,
                        child: Tab(
                          icon: Icon(FontAwesomeIcons.globeAsia, size: 20),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20,
                        child: Tab(
                          icon: Icon(FontAwesomeIcons.listAlt, size: 20),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 20,
                        child: Tab(
                          icon: Icon(FontAwesomeIcons.flag, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: tabBarController,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2, right: 2),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.99,
                  child: Center(
                      child: ListView(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    (worldData == null)
                        ? Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.5,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.cyanAccent[100],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'WORLD AT GLANCE',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.cyanAccent[100],
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.075),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                (newData == null)
                                    ? Container(
                                        height: 200,
                                        width: 200,
                                        child: Center(
                                          child: SpinKitThreeBounce(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Stack(
                                        children: <Widget>[
                                          PieChartData(newData),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.80,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.80,
                                            child: Icon(
                                              FontAwesomeIcons.globeAmericas,
                                              color: Colors.white60,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.55,
                                            ),
                                          )
                                        ],
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        GlobalData(
                                          worldData: worldData,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                worldData == null ? SizedBox() : Link(),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                  ])),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2, right: 2, top: 0, bottom: 0),
                child: (countryData == null)
                    ? Center(
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.cyanAccent[100],
                          ),
                        ),
                      )
                    : Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: TextField(
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.065,
                                  color: Colors.white),
                              controller: editingController,
                              maxLength: 40,
                              onChanged: (value) {
                                setState(() {
                                  filterSearchResults(value);
                                });
                              },
                              decoration: InputDecoration(
                                counter: SizedBox.shrink(),
                                //labelText: "Search",
                                fillColor: Colors.white,
                                hintText: "Search",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Arimo',
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.055),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                suffix: IconButton(
                                  icon: Icon(Icons.clear),
                                  iconSize: 20,
                                  alignment: Alignment.bottomRight,
                                  onPressed: null,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  gapPadding: 0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: countryData == null
                                      ? 0
                                      : suggestions.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          tabBarController.animateTo(2);
                                          setState(() {
                                            countryMaxDetail =
                                                suggestions[index];
                                            countryStackIndex =
                                                suggestions[index]['country'];
                                            fetchHistory();
                                            print(countryStackIndex);
                                            //countryStack = stackBarData;
                                            print(countryStack);
                                          });
                                        },
                                        child: DynamicList(
                                            suggestions, index, countryData));
                                  })),
                        ],
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*0.03 ,
                    right: MediaQuery.of(context).size.width*0.03,
                    top: 0,
                    bottom: 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.99,
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        (countryData == null)
                            ? Column(
                                children: <Widget>[
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.width * 0.5,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.cyanAccent[100],
                                    ),
                                  ),
                                ],
                              )
                            : SelectedCountry(countryMaxDetail, countryStack),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval) {
    taskvalue = double.parse(taskvalue.toStringAsFixed(1));
  }
}

double Tsize(String ctext) {
  if (ctext.length >= 18) {
    return 20;
  } else if (ctext.length >= 20) {
    return 16;
  } else {
    return 24;
  }
}

String Ttext(String dtext) {
  return dtext.toUpperCase();
}

double Tsize2(String ctext) {
  if (ctext.length <= 7) {
    return 40;
  } else if (ctext.length >= 18) {
    return 30;
  } else if (ctext.length >= 20) {
    return 26;
  } else {
    return 34;
  }
}
