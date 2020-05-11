import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChartIndia extends StatefulWidget {
  var indiaData;

  PieChartIndia(this.indiaData);

  @override
  _PieChartIndiaState createState() => _PieChartIndiaState();
}

class _PieChartIndiaState extends State<PieChartIndia> {
  List<charts.Series> seriesPieData;

  List<charts.Series<Task, String>> seriesPieChart(var newData) {
    var pieData = [
      Task(
          'Active',
          (int.parse(newData['statewise'][0]['active']) /
              int.parse(newData['statewise'][0]['confirmed']) *
              100),
          Colors.yellowAccent
          //Colors.blue
          ),
      Task(
          'Recovered',
          (int.parse(newData['statewise'][0]['recovered']) /
              int.parse(newData['statewise'][0]['confirmed']) *
              100),
          Colors.lightGreenAccent[400]
          //Colors.green
          ),
      Task(
          'Deaths',
          (int.parse(newData['statewise'][0]['deaths']) /
                  int.parse(newData['statewise'][0]['confirmed'])) *
              100,
          Colors.deepOrangeAccent[400]
          //Colors.red
          ),
    ];

    return [
      charts.Series(
        data: pieData,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
        id: 'Chart',
      )
    ];
  }

  void initState() {
    super.initState();
    setState(() {
      seriesPieData = seriesPieChart(widget.indiaData);
    });
  }

  pieChart() {
    return charts.PieChart(
      seriesPieData,
      animate: true,
      animationDuration: Duration(milliseconds: 500),
      defaultRenderer: charts.ArcRendererConfig(
        strokeWidthPx: 0,
        arcWidth: 10,
        arcRendererDecorators: [
          charts.ArcLabelDecorator(
            outsideLabelStyleSpec: charts.TextStyleSpec(
              color: charts.Color.white,
              fontSize: 14,
            ),
            showLeaderLines: false,
            labelPosition: charts.ArcLabelPosition.outside,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.80,
      width: MediaQuery.of(context).size.width * 0.80,
      child: widget.indiaData == null ? SizedBox() : pieChart(),
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
