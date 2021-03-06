import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DynamicList extends StatefulWidget {
  List suggestions, countryData;
  int index;

  DynamicList(this.suggestions, this.index, this.countryData);

  @override
  _DynamicListState createState() => _DynamicListState();
}

class _DynamicListState extends State<DynamicList> {
  _DynamicListState();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      borderOnForeground: false,
      //color: Color(0xff233656),
      color: Color(0xff115173),
      child: Container(
        //height: size * 0.45,
        height: 160,
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Color(0xff115173),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: size * 0.015,
            ),
            Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: CachedNetworkImageProvider(widget
                        .suggestions[widget.index]['countryInfo']['flag']),
                    width: size * 0.27,
                    height: 150,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: size * 0.01,
                ),
                Text(
                  Ttext(widget.suggestions[widget.index]['country']),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: customSize(
                        widget.suggestions[widget.index]['country'], size),
                  ),
                ),
                SizedBox(
                  height: size * 0.008,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'CONFIRMED:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.lightBlueAccent,
                                fontSize: size * 0.035),
                          ),
                          Text(
                            widget.suggestions[widget.index]['cases']
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.cyan[100],
                                fontSize: size * 0.06),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'ACTIVE:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.yellowAccent[400],
                                fontSize: size * 0.035),
                          ),
                          Text(
                            widget.suggestions[widget.index]['active']
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.cyan[100],
                                fontSize: size * 0.06),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'RECOVERED:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.lightGreenAccent[400],
                                fontSize: size * 0.035),
                          ),
                          Text(
                            widget.suggestions[widget.index]['recovered']
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.cyan[100],
                                fontSize: size * 0.06),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'DEATHS:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.deepOrange,
                                fontSize: size * 0.035),
                          ),
                          Text(
                            widget.suggestions[widget.index]['deaths']
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.cyan[100],
                                fontSize: size * 0.06),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

double customSize(String text, double size) {
  if (text.length <= 7) {
    return size * 0.07;
  } else if (text.length > 7 && text.length <= 14) {
    return size * 0.065;
  } else if (text.length > 14 && text.length <= 20) {
    return size * 0.05;
  } else {
    return size * 0.04;
  }
}

String Ttext(String dtext) {
  return dtext.toUpperCase();
}
