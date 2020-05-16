import 'package:covid19/apiresources/apiStackChart.dart';
import 'package:covid19/tabbar/tabbar1.dart';
import 'package:covid19/widgets/dynamicList.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  var data;

  CountryPage(this.data);

  @override
  CountryPageState createState() => CountryPageState();
}

class CountryPageState extends State<CountryPage> {
  TextEditingController controller;
  TextEditingController editingController = TextEditingController();
  var listController = ScrollController();

  List countryData, suggestions;

  static var countryMaxDetails, countryStackIndex, countryStack;

  //String savename;

  fetchCountryData() {
    getStackData(var x) async {
      countryStack = null;
      countryStack = await fetchChartData(
          'https://corona.lmao.ninja/v2/historical/$x',
          30,
          1,
          1,
          'stack$countryStackIndex',
          1);
      return countryStack;
    }

    setState(() {
      countryData = widget.data;
      suggestions = countryData;
      print(countryData);
    });
  }

  void initState() {
    super.initState();
    fetchCountryData();
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

  @override
  Widget build(BuildContext context) {
    double aspectRatio = double.parse(
        (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height)
            .toStringAsFixed(1));

    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Container(
            //color: Color(0xff233656),
            //color: Color(0xff053f5e),
            color: Colors.transparent,
            height: aspectRatio == 0.6
                ? MediaQuery.of(context).size.height * 0.1
                : MediaQuery.of(context).size.height * 0.07,
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
                    color: Colors.white,
                    iconSize: 20,
                    alignment: Alignment.bottomRight,
                    onPressed: () {
                      filterSearchResults('');
                      editingController.clear();
                    }),
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
          Flexible(
              child: ListView.builder(
                  controller: listController,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: countryData == null ? 0 : suggestions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Future.delayed(Duration(milliseconds: 5), () {
                            setState(() {
                              countryMaxDetails = suggestions[index];
                              countryStackIndex = suggestions[index]['country'];
                            });
                          });
                          Future.delayed(Duration(milliseconds: 10), () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          });
                          Future.delayed(Duration(milliseconds: 100), () {
                            FirstTabState.tabBarController1.animateTo(2);
                          });

                          //Navigator.push(
                          //  context,
                          //  MaterialPageRoute(
                          //      builder: (context) => CountryDetails(
                          //          suggestions[index],
                          //          suggestions[index]['country'])),
                          //);
                          print('verify' + suggestions[index]['country']);
                        },
                        //() {
                        //  FocusScope.of(context)
                        //      .requestFocus(new FocusNode());
                        //  tabBarController.animateTo(2);
                        //  setState(() {
                        //    countryMaxDetail =
                        //        suggestions[index];
                        //    countryStackIndex =
                        //        suggestions[index]['country'];
                        //    fetchHistory();
                        //    print(countryStackIndex);
                        //    //countryStack = stackBarData;
                        //    print(countryStack);
                        //  });
                        //},
                        child: DynamicList(suggestions, index, countryData));
                  })),
        ],
      ),
    );
  }
}
