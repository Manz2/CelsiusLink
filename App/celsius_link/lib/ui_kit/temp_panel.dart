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
        AspectRatio(
          aspectRatio: 2,
          child: LineChart(LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: false,
                dotData: const FlDotData(show: false),
              )
            ],
            borderData: FlBorderData(
                border: const Border(bottom: BorderSide(), left: BorderSide())),
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(sideTitles: _bottomTitles),
              leftTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
          )),
        ),
      ],
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(value.toInt());
          String formattedDate = DateFormat('hh:mm').format(dateTime);
          return Text(formattedDate);
        },
      );
}
