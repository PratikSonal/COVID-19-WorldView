import 'package:covid19/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../homepage.dart';
import '../myapp.dart';

class ErrorPage extends StatefulWidget {
  String a, b;
  ErrorPage(this.a, this.b);
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Center(
            child: Icon(
              Icons.error,
              size: MediaQuery.of(context).size.width * 0.15,
              color: Colors.cyan[100],
            ),
          ),
          Center(
            child: Text(
              widget.a,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.07,
                color: Colors.cyan[100],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.006,
          ),
          Center(
            child: Text(
              widget.b,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: Colors.cyan[100],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.25,
            child: RaisedButton(
              child: Text(
                'Retry',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
              color: Color(0xff14ffec),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: Colors.cyan[100])),
              onPressed: () => Phoenix.rebirth(context),
              //Navigator.push(context,PageRouteBuilder(pageBuilder: (context, animation1, animation2) => MyApp(),),),
            ),
          ),
        ],
      ),
    );
  }
}
