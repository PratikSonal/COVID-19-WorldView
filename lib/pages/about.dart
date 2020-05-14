import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var displayHeight = size.height;
    var displayWidth = size.width;
    return Scaffold(
      backgroundColor: Color(0xff053f5e),
      appBar: AppBar(
        backgroundColor: Color(0xff022c43),
        title: Text('ABOUT'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: displayWidth * 0.05),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.asset('assets/images/Logo.png'),
                    ),
                    Text(
                      'COVID-19\nWORLDVIEW',
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: MediaQuery.of(context).size.width * 0.09,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'By Pratik Sonal',
                  style: TextStyle(
                    color: Colors.cyan[100],
                  ),
                ),
              ),
              SizedBox(
                height: displayHeight * 0.15,
              ),
              Center(
                child: Text(
                  'Hi there!',
                  style: TextStyle(
                    color: Colors.cyan[100],
                    fontSize: displayWidth * 0.06,
                  ),
                ),
              ),
              SizedBox(
                height: displayHeight * 0.02,
              ),
              Center(
                child: Text(
                  'First of all, I would like to take a moment to thank you for using this app. It means a lot to me to know that something I’ve created is being put into good use.',
                  style: TextStyle(
                    color: Colors.cyan[100],
                    fontSize: displayWidth * 0.04,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: displayHeight * 0.02,
              ),
              Center(
                child: Text(
                  'I made this app in an attempt to get a better understanding of flutter and to put my knowledge into action. Well, I couldn’t do much during lockdown anyways, so this was a fun little project to work on. It took me far longer than I expected to finish this app to a stable build, but this is my first ever application, and I’m certainly proud of it.',
                  style: TextStyle(
                    color: Colors.cyan[100],
                    fontSize: displayWidth * 0.04,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: displayHeight * 0.02,
              ),
              Center(
                child: Text(
                  'This app is as good as the sources it’s pulling the data from. There won’t be anything to show once the sources are dismissed. But be certain that I’ll keep the app updated for as long as I can. You can check out the source code on in the details section right below.',
                  style: TextStyle(
                    color: Colors.cyan[100],
                    fontSize: displayWidth * 0.04,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: displayHeight * 0.02,
              ),
              Center(
                child: Text(
                  'At last, it’s a dangerous world out there. Stay home, stay safe.',
                  style: TextStyle(
                    color: Colors.cyan[100],
                    fontSize: displayWidth * 0.04,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2 ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
