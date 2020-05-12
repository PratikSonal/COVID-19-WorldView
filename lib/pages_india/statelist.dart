import 'package:covid19/pages_india/statedetails.dart';
import 'package:covid19/tabbar/tabbar1.dart';
import 'package:covid19/tabbar/tabbar3.dart';
import 'package:covid19/widgets_india/dynamicListIndia.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StatePage extends StatefulWidget {
  var data1, data2;

  StatePage(this.data1, this.data2);
  @override
  StatePageState createState() => StatePageState();
}

class StatePageState extends State<StatePage> {
  TextEditingController controller;
  TextEditingController editingController = TextEditingController();
  var listController = ScrollController();

  List stateData, suggestions;
  Map stateDataDetails;

  static String stateName, stateCode ;

  static var stateMaxDetails, stateStackIndex, stateStack;

  fetchStateData() async {
    //http.Response response = await http
    //    .get('https://api.covid19india.org/v2/state_district_wise.json');
    //http.Response response2 =
    //    await http.get('https://api.covid19india.org/data.json');

    setState(() {
      stateData = widget.data1; //json.decode(response.body);
      stateDataDetails = widget.data2; //json.decode(response2.body);
      suggestions = stateData;
      print(stateData);
    });
  }

  void initState() {
    super.initState();
    fetchStateData();
  }

  filterSearchResults(String query) {
    setState(() {
      suggestions = query.isEmpty
          ? stateData
          : stateData
              .where((element) => element['state']
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Container(
            //color: Color(0xff233656),
            color: Color(0xff053f5e),
            height: MediaQuery.of(context).size.height * 0.07,
            child: Container(
              child: TextField(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.065,
                    color: Colors.white),
                controller: editingController,
                maxLength: 40,
                onChanged: (value) {
                  listController.jumpTo(0.0);
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
                      fontSize: MediaQuery.of(context).size.width * 0.055),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
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
                  //border: OutlineInputBorder(
                  //  borderSide: BorderSide(
                  //    color: Colors.white,
                  //  ),
                  //  gapPadding: 0,
                  //  borderRadius:
                  //      BorderRadius.all(Radius.circular(25.0)),
                  //),
                ),
              ),
            ),
          ),
          Flexible(
              child: ListView.builder(
                  controller: listController,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: false,
                  itemCount: (stateData == null || stateDataDetails == null)
                      ? 0
                      : suggestions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            SelectedStateDetailsState.counter = 0;
                            stateName = suggestions[index]['state'].toString();
                            stateCode = suggestions[index]['statecode'].toString();
                            //stateMaxDetails = suggestions[index];
                            //stateStackIndex = suggestions[index]['state'];
                          });
                          ThirdTabState.tabBarController1.animateTo(2);
                          FocusScope.of(context).requestFocus(new FocusNode());
                          //FirstTabState.tabBarController1.animateTo(2);
                          //print('verify' + suggestions[index]['state']);
                        },
                        //() {
                        //  FocusScope.of(context)
                        //      .requestFocus(new FocusNode());
                        //  tabBarController.animateTo(2);
                        //  setState(() {
                        //    stateMaxDetail =
                        //        suggestions[index];
                        //    stateStackIndex =
                        //        suggestions[index]['state'];
                        //    fetchHistory();
                        //    print(stateStackIndex);
                        //    //stateStack = stackBarData;
                        //    print(stateStack);
                        //  });
                        //},
                        child: DynamicListIndia(
                            suggestions, index, stateData, stateDataDetails));
                  })),
        ],
      ),
    );
  }
}

getSync(var indiaStateDistData, Map data2, var index) {
  for (int i = 0; i <= data2['statewise'].length - 1; i++) {
    if (indiaStateDistData[index]['state'] == data2['statewise'][i]['state']) {
      print(indiaStateDistData[index]['state'].toString() +
          data2['statewise'][i]['state'].toString());
      return i;
    }
  }
}
