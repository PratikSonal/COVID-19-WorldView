import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChartData extends StatelessWidget {
  var pieChartData;

  PieChartData(this.pieChartData);
  List<charts.Series> seriesPieData;

  List<charts.Series<Task, String>> seriesPieChart(var newData) {
    var pieData = [
      Task('Active', (newData['active'] / newData['cases'] * 100),
          Colors.yellowAccent
          //Colors.blue
          ),
      Task('Recovered', (newData['recovered'] / newData['cases'] * 100),
          Colors.lightGreenAccent[400]
          //Colors.green
          ),
      Task('Deaths', (newData['deaths'] / newData['cases']) * 100,
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

  //void initState() {
  //  super.initState();
  //  setState(() {
  //    seriesPieData = seriesPieChart(pieChartData);
  //  });
  //}

  pieChart() {
    return charts.PieChart(
      //seriesPieData,
      seriesPieChart(pieChartData),
      animate: true,
      animationDuration: Duration(milliseconds: 350),
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
      child: pieChartData == null ? SizedBox() : pieChart(),
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
