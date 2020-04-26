import './stackChart.dart';
import 'package:flutter/material.dart';
import '../homepage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SelectedCountry extends StatefulWidget {
  Map countryMaxDetail;
  var countryStack;

  SelectedCountry(this.countryMaxDetail, this.countryStack);

  @override
  _SelectedCountryState createState() => _SelectedCountryState();
}

class _SelectedCountryState extends State<SelectedCountry> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        SizedBox(
          height: size * 0.03,
        ),
        widget.countryMaxDetail == null
            ? Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size * 0.7),
                    Center(
                      child: Text(
                        'NO COUNTRY SELECTED',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.065),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Center(
                      child: Text(
                        'Select a country from the country list and see additional details',
                        style: TextStyle(
                            fontSize: size * 0.04, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: size * 0.25,
                      width: size * 0.4,
                      child: Image.network(
                        widget.countryMaxDetail['countryInfo']['flag'],
                      ),
                    ),
                    Container(
                      height: size * 0.25,
                      width: size * 0.5,
                      alignment: Alignment.center,
                      child: Text(
                        Ttext(widget.countryMaxDetail['country']),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: customText2(
                              widget.countryMaxDetail['country'], size),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        widget.countryMaxDetail == null
            ? SizedBox()
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: size * 0.08,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'CONFIRMED',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white),
                      ),
                      Text(
                        widget.countryMaxDetail['cases'].toString(),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white),
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
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white),
                      ),
                      Text(
                        widget.countryMaxDetail['active'].toString(),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white),
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
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white),
                      ),
                      Text(
                        widget.countryMaxDetail['recovered'].toString(),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: size * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'CASES PER MILLION',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.055,
                            color: Colors.white),
                      ),
                      Text(
                        widget.countryMaxDetail['casesPerOneMillion']
                            .toString(),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: size * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'TESTING PER MILLION',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.055,
                            color: Colors.white),
                      ),
                      Text(
                        widget.countryMaxDetail['testsPerOneMillion']
                            .toString(),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white),
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
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white),
                      ),
                      Text(
                        widget.countryMaxDetail['deaths'].toString(),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: size * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'DEATHS PER MILLION',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.055,
                            color: Colors.white),
                      ),
                      Text(
                        widget.countryMaxDetail['deathsPerOneMillion']
                            .toString(),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: size * 0.055),
                ],
              ),
        widget.countryStack == null
            ? SizedBox(
                child: SpinKitThreeBounce(
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.4,
              )
            : (widget.countryStack['message'] != null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                      child: Text(
                        'Nothing else to show',
                        style: TextStyle(
                            fontSize: size * 0.055, color: Colors.white60),
                      ),
                    ),
                  )
                : StackChart(widget.countryStack)),
      ],
    );
  }
}

double customText2(String text, double size) {
  if (text.length <= 7) {
    return size * 0.075;
  } else if (text.length > 7 && text.length <= 14) {
    return size * 0.060;
  } else if (text.length > 14 && text.length <= 20) {
    return size * 0.055;
  } else {
    return size * 0.045;
  }
}