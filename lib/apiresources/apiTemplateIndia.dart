import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:covid19/countryentrypage.dart';
import 'package:covid19/pages/countrypage.dart';
import 'package:covid19/pages/error.dart';
import 'package:covid19/pages/worldpage.dart';
import 'package:covid19/pages_india/homepageIndia.dart';
import 'package:covid19/pages_india/statedetails.dart';
import 'package:covid19/pages_india/statelist.dart';
import 'package:flutter/material.dart';

//import './model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//class ApiTemp {
//static const HOST = 'corona.lmao.ninja';
//static const URL_GLOBAL = 'http://$HOST/v2/all';
//static const URL_COUNTRIES = 'http://$HOST/v2/countries';
//static const TIMEOUT = 10; // 10s http timeout
//static const SLEEP = 1000; // 1s sleep to prevent rate-limiting
//static const TIME_UNTIL_NEXT_FETCH = 60000; // 60s caching
//static const FAKE_FETCH_TIME = 1985; // 1.985s of fake loading

//String url;int timeout;int sleep;int waitTime;int fakeWait;

//ApiTemp({this.url, this.timeout, this.sleep, this.waitTime, this.fakeWait}) {

//}

Future<Scaffold> fetchIndia(
  int timeout1,
  int sleep1,
  int fakeWait1,
  String saveName,
  int cacheTime,
  int returnType,
) async {
  if (await _shouldFetch(cacheTime, saveName)) {
    try {
      final responseIndia1 = await http
          .get('https://api.covid19india.org/data.json')
          .timeout(Duration(seconds: timeout1));
      _checkResponseCode(responseIndia1);
      final responseIndia2 = await http
          .get('https://api.covid19india.org/v2/state_district_wise.json')
          .timeout(Duration(seconds: timeout1));
      _checkResponseCode(responseIndia1);
      final responseIndia3 = await http
          .get('https://api.covid19india.org/zones.json')
          .timeout(Duration(seconds: timeout1));
      _checkResponseCode(responseIndia1);

      await _sleep(sleep1);

      final prefs = await SharedPreferences.getInstance();
      prefs.setInt(
          'lastFetchTimestamp$saveName', DateTime.now().millisecondsSinceEpoch);

      // save the jsons to file
      await _writeToFile(saveName + '1', responseIndia1.body);
      await _writeToFile(saveName + '2', responseIndia2.body);
      await _writeToFile(saveName + '3', responseIndia3.body);

      print('success1');

      //return json.decode(responseIndia1.body);

      if (returnType == 1) {
        return Scaffold(
          backgroundColor: Color(0xff053f5e),
          body: IndiaPage(json.decode(responseIndia1.body)),
        );
      } else if (returnType == 2) {
        //print(json.decode(responseIndia1.body));
        return Scaffold(
          backgroundColor: Color(0xff053f5e),
          body: StatePage(json.decode(responseIndia2.body),
              json.decode(responseIndia1.body)),
        );
      } else if (returnType == 3) {
        return Scaffold(
          backgroundColor: Color(0xff053f5e),
          body: SelectedStateDetails(
              json.decode(responseIndia2.body),
              json.decode(responseIndia3.body),
              json.decode(responseIndia1.body)),
        );
      }
    } on TimeoutException catch (e) {
      await _sleep(fakeWait1);
      //throw ApiTempException(cause: 'a', action: 'b');
      return Scaffold(
        backgroundColor: Color(0xff022c43),
        body: ErrorPage('Connection timed out', 'Please try again'),
      );
    } on SocketException catch (e) {
      await _sleep(fakeWait1);
      //throw ApiTempException(cause: 'c', action: 'd');
      return Scaffold(
        backgroundColor: Color(0xff022c43),
        body: ErrorPage(
            'Network error', 'Please connect to a network and try again'),
      );
    }
  } else {
    await _sleep(fakeWait1);
    print('success2');
    //return json.decode(await _readFromFile(saveName));

    //print(json.decode(await _readFromFile(saveName)));

    if (returnType == 1) {
      return Scaffold(
        backgroundColor: Color(0xff053f5e),
        body: IndiaPage(json.decode(await _readFromFile(saveName + '1'))),
      );
    } else if (returnType == 2) {
      return Scaffold(
        backgroundColor: Color(0xff053f5e),
        body: StatePage(json.decode(await _readFromFile(saveName + '2')),
            json.decode(await _readFromFile(saveName + '1'))),
      );
    } else if (returnType == 3) {
      return Scaffold(
          backgroundColor: Color(0xff053f5e),
          body: SelectedStateDetails(
              json.decode(await _readFromFile(saveName + '2')),
              json.decode(await _readFromFile(saveName + '3')),
              json.decode(await _readFromFile(saveName + '1'))));
    }
  }
}

//static
Future<void> _writeToFile(String filename, dynamic data) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$filename.json');
  file.writeAsString(data);
}

//static
Future<String> _readFromFile(String filename) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$filename.json');
  return file.readAsString();
}

//static
Future<bool> _shouldFetch(int time, String saveName) async {
  final prefs = await SharedPreferences.getInstance();
  String s = 'lastFetchTimestamp' + saveName;
  int lastFetchTimestamp = prefs.getInt(s) ?? -1;
  if (lastFetchTimestamp < 0) {
    return true;
  } else if (DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(
      lastFetchTimestamp + (time * 60000)))) {
    return true;
  } else {
    //return false;
    return false;
  }
}

//static
void _checkResponseCode(response) {
  int code = response.statusCode;
  if (code == 200)
    return;
  else if (code == 429) {
    String action = response.headers['retry-after'] != null
        ? "Retry after ${response.headers['retry-after']} seconds"
        : 'Retry after a few minutes';
    throw ApiTempException(
      cause: 'Request limit reached',
      action: action,
    );
  } else if (code >= 500 && code < 600) {
    // cloudfare errors usually happen
    throw ApiTempException(
      cause: 'Error ${response.statusCode}: ${response.reasonPhrase}',
      action: 'Please hit refresh after a few seconds',
    );
  } else {
    throw ApiTempException(
      cause: 'Error ${response.statusCode}: ${response.reasonPhrase}',
      action: 'Please send a screenshot to developer',
    );
  }
}

//static
Future _sleep(int millis) {
  return Future.delayed(Duration(milliseconds: millis * 10));
}
//}

class Model {
  var globe;
  var country;
  Model(this.globe, this.country);
}

class ApiTempException implements Exception {
  final String cause;
  final String action;

  ApiTempException({this.cause, this.action});

  String toString() => "${this.cause} ${this.action}";
}
