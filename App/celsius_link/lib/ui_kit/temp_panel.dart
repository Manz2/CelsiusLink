import 'package:celsius_link/screens/home/home_model.dart';
import 'package:celsius_link/screens/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class TempPanel extends StatelessWidget {
  final HomeController controller;
  final HomeModel model;
  const TempPanel({super.key, required this.controller, required this.model});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = model.temperatureToday
        .map((entry) => FlSpot(
            entry.keys.first.millisecondsSinceEpoch.toDouble(),
            entry.values.first))
        .toList();

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding:
                const EdgeInsets.only(bottom: 15, top: 80, left: 3, right: 50),
            width: MediaQuery.of(context).size.height * 6,
            height: MediaQuery.of(context).size.height / 3,
            child: LineChart(LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: false,
                  dotData: const FlDotData(show: true),
                )
              ],
              borderData: FlBorderData(
                  border:
                      const Border(bottom: BorderSide(), left: BorderSide())),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                leftTitles: AxisTitles(sideTitles: _sideTitles),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            )),
          ),
        ),
      ],
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(value.toInt(), isUtc: true);
          String formattedDate = DateFormat('hh:mm').format(dateTime.toLocal());
          print("object");
          print(dateTime);
          print(dateTime.toLocal());
          return Text(formattedDate);
        },
      );
  SideTitles get _sideTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return Text(value.toInt().toString());
        },
      );
}
