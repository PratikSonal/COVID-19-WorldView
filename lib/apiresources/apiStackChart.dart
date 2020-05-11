import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:covid19/pages/error.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var null2 = 0, null3 = 1;

fetchChartData(
  String url1,
  int timeout1,
  int sleep1,
  int fakeWait1,
  var saveName,
  int cacheTime,
) async {
  if (await _shouldFetch(cacheTime, saveName)) {
    try {
      final responseGlobal =
          await http.get(url1).timeout(Duration(seconds: timeout1));

      await _sleep(sleep1);

      final prefs = await SharedPreferences.getInstance();
      prefs.setInt(
          'lastFetchTimestamp$saveName', DateTime.now().millisecondsSinceEpoch);
      print('first' + 'lastFetchTimestamp$saveName');

      // save the jsons to file
      await _writeToFile(saveName, responseGlobal.body);

      print('VARnew1');

      return json.decode(responseGlobal.body);

      //print(json.decode(responseGlobal.body));

    } on TimeoutException catch (e) {
      await _sleep(fakeWait1);
      //throw ApiTempException(cause: 'a', action: 'b');
      //return Scaffold(
      //  body: ErrorPage('a', 'b'),
      //);
      return null2;
    } on SocketException catch (e) {
      await _sleep(fakeWait1);
      //throw ApiTempException(cause: 'c', action: 'd');
      //return Scaffold(
      //  body: ErrorPage('c', 'd'),
      //);
      return null3;
    }
  } else {
    await _sleep(fakeWait1);
    print('VARnew2');
    return json.decode(await _readFromFile(saveName));

    //print(json.decode(await _readFromFile(saveName)));
  }
}

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
  //final prefs = await SharedPreferences.getInstance();
  final prefs = await SharedPreferences.getInstance();
  //int lastFetchTimestamp = saveName.getInt('lastFetchTimestamp') ?? -1;
  String s = 'lastFetchTimestamp' + saveName;
  int lastFetchTimestamp = prefs.getInt(s) ?? -1;
  print('last' + s);
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

Future _sleep(int sec) {
  return Future.delayed(Duration(seconds: sec));
}
