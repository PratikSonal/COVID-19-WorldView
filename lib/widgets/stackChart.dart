import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class StackChart extends StatefulWidget {
  var countryStack;

  StackChart(this.countryStack);

  @override
  _StackChartState createState() => _StackChartState();
}

class _StackChartState extends State<StackChart> {
  List<charts.Series> seriesList;

  static List<charts.Series<CLine, int>> createStackData(var historyData) {
    final caseCLineData = [
      CLine(0, caseData(historyData, 30)),
      CLine(1, caseData(historyData, 29)),
      CLine(2, caseData(historyData, 28)),
      CLine(3, caseData(historyData, 27)),
      CLine(4, caseData(historyData, 26)),
      CLine(5, caseData(historyData, 25)),
      CLine(6, caseData(historyData, 24)),
      CLine(7, caseData(historyData, 23)),
      CLine(8, caseData(historyData, 22)),
      CLine(9, caseData(historyData, 21)),
      CLine(10, caseData(historyData, 20)),
      CLine(11, caseData(historyData, 19)),
      CLine(12, caseData(historyData, 18)),
      CLine(13, caseData(historyData, 17)),
      CLine(14, caseData(historyData, 16)),
      CLine(15, caseData(historyData, 15)),
      CLine(16, caseData(historyData, 14)),
      CLine(17, caseData(historyData, 13)),
      CLine(18, caseData(historyData, 12)),
      CLine(19, caseData(historyData, 11)),
      CLine(20, caseData(historyData, 10)),
      CLine(21, caseData(historyData, 9)),
      CLine(22, caseData(historyData, 8)),
      CLine(23, caseData(historyData, 7)),
      CLine(24, caseData(historyData, 6)),
      CLine(25, caseData(historyData, 5)),
      CLine(26, caseData(historyData, 4)),
      CLine(27, caseData(historyData, 3)),
      CLine(28, caseData(historyData, 2)),
      CLine(29, caseData(historyData, 1)),
    ];

    final recCLineData = [
      CLine(0, recoveredData(historyData, 30)),
      CLine(1, recoveredData(historyData, 29)),
      CLine(2, recoveredData(historyData, 28)),
      CLine(3, recoveredData(historyData, 27)),
      CLine(4, recoveredData(historyData, 26)),
      CLine(5, recoveredData(historyData, 25)),
      CLine(6, recoveredData(historyData, 24)),
      CLine(7, recoveredData(historyData, 23)),
      CLine(8, recoveredData(historyData, 22)),
      CLine(9, recoveredData(historyData, 21)),
      CLine(10, recoveredData(historyData, 20)),
      CLine(11, recoveredData(historyData, 19)),
      CLine(12, recoveredData(historyData, 18)),
      CLine(13, recoveredData(historyData, 17)),
      CLine(14, recoveredData(historyData, 16)),
      CLine(15, recoveredData(historyData, 15)),
      CLine(16, recoveredData(historyData, 14)),
      CLine(17, recoveredData(historyData, 13)),
      CLine(18, recoveredData(historyData, 12)),
      CLine(19, recoveredData(historyData, 11)),
      CLine(20, recoveredData(historyData, 10)),
      CLine(21, recoveredData(historyData, 9)),
      CLine(22, recoveredData(historyData, 8)),
      CLine(23, recoveredData(historyData, 7)),
      CLine(24, recoveredData(historyData, 6)),
      CLine(25, recoveredData(historyData, 5)),
      CLine(26, recoveredData(historyData, 4)),
      CLine(27, recoveredData(historyData, 3)),
      CLine(28, recoveredData(historyData, 2)),
      CLine(29, recoveredData(historyData, 1)),
    ];

    final deadCLineData = [
      CLine(0, deathData(historyData, 30)),
      CLine(1, deathData(historyData, 29)),
      CLine(2, deathData(historyData, 28)),
      CLine(3, deathData(historyData, 27)),
      CLine(4, deathData(historyData, 26)),
      CLine(5, deathData(historyData, 25)),
      CLine(6, deathData(historyData, 24)),
      CLine(7, deathData(historyData, 23)),
      CLine(8, deathData(historyData, 22)),
      CLine(9, deathData(historyData, 21)),
      CLine(10, deathData(historyData, 20)),
      CLine(11, deathData(historyData, 19)),
      CLine(12, deathData(historyData, 18)),
      CLine(13, deathData(historyData, 17)),
      CLine(14, deathData(historyData, 16)),
      CLine(15, deathData(historyData, 15)),
      CLine(16, deathData(historyData, 14)),
      CLine(17, deathData(historyData, 13)),
      CLine(18, deathData(historyData, 12)),
      CLine(19, deathData(historyData, 11)),
      CLine(20, deathData(historyData, 10)),
      CLine(21, deathData(historyData, 9)),
      CLine(22, deathData(historyData, 8)),
      CLine(23, deathData(historyData, 7)),
      CLine(24, deathData(historyData, 6)),
      CLine(25, deathData(historyData, 5)),
      CLine(26, deathData(historyData, 4)),
      CLine(27, deathData(historyData, 3)),
      CLine(28, deathData(historyData, 2)),
      CLine(29, deathData(historyData, 1)),
    ];

    return [
      charts.Series<CLine, int>(
        id: 'Confirmed',
        domainFn: (CLine cLine, _) => cLine.day,
        measureFn: (CLine cLine, _) => cLine.data,
        data: caseCLineData,
        colorFn: (CLine cLine, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
      ),
      charts.Series<CLine, int>(
        id: 'Recovered',
        domainFn: (CLine cLine, _) => cLine.day,
        measureFn: (CLine cLine, _) => cLine.data,
        data: recCLineData,
        colorFn: (CLine cLine, _) {
          return charts.MaterialPalette.green.shadeDefault;
        },
      ),
      charts.Series<CLine, int>(
        id: 'Deaths',
        domainFn: (CLine cLine, _) => cLine.day,
        measureFn: (CLine cLine, _) => cLine.data,
        data: deadCLineData,
        colorFn: (CLine cLine, _) {
          return charts.MaterialPalette.red.shadeDefault;
        },
      ),
    ];
  }

  void initState() {
    super.initState();
    setState(() {
      seriesList = createStackData(widget.countryStack);
    });
  }

  lineChart() {
    return charts.LineChart(
      seriesList,
      primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
          color: charts.Color.white,
          fontSize: 12,
        ),
        lineStyle: charts.LineStyleSpec(color: charts.Color.white),
      )),
      domainAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
          color: charts.Color.white,
          fontSize: 12,
        ),
        lineStyle: charts.LineStyleSpec(color: charts.Color.transparent),
      )),
      animate: true,
      behaviors: [
        charts.SeriesLegend(
          //showMeasures: true,
          entryTextStyle:
              charts.TextStyleSpec(color: charts.Color.white, fontSize: 13),
        )
      ],
      defaultRenderer: charts.LineRendererConfig(
        areaOpacity: 0.4,
        includeArea: true,
        stacked: false,
        includeLine: true,
        includePoints: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.8,
      width: MediaQuery.of(context).size.width * 0.95,
      //padding: EdgeInsets.all(1),
      child: widget.countryStack == null ? SizedBox() : lineChart(),
    );
  }
}

class CLine {
  final int day;
  final int data;

  CLine(this.day, this.data);
}

dateRen(int previous) {
  var date = DateTime.now();
  var dateMod = date.subtract(Duration(days: previous));
  String blue = DateFormat('M/d/yy').format(dateMod);
  return blue;
}

dateRend(int previous) {
  var date = DateTime.now();
  var dateMod = date.subtract(Duration(days: previous));
  String blue = DateFormat('M/d').format(dateMod);
  return blue;
}

caseData(var countryStack, int sub) {
  var cd = countryStack['timeline']['cases'][dateRen(sub).toString()];
  return cd;
}

deathData(var countryStack, int sub) {
  var dd = countryStack['timeline']['deaths'][dateRen(sub).toString()];
  return dd;
}

recoveredData(var countryStack, int sub) {
  var rd = countryStack['timeline']['recovered'][dateRen(sub).toString()];
  return rd;
}
