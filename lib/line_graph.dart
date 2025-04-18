import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildLineChart(
  int totalDays,
  List<int> viewsPerDay,
  String X_axis_heading,
  String Y_axis_heading,
  String Graph_heading,
) {
  List<FlSpot> spots = [];
  double maxY = 0;

  for (int i = 0; i < totalDays && i < viewsPerDay.length; i++) {
    double y = viewsPerDay[i].toDouble();
    spots.add(FlSpot((i + 1).toDouble(), y));
    if (y > maxY) maxY = y;
  }

  int maxXLabels = 6;
  int xInterval = (totalDays / maxXLabels).ceil();
  double yInterval = (maxY / 5).ceilToDouble();

  return Container(
    width: 500, 
    height: 400,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            Graph_heading,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 320,
          child: LineChart(
            LineChartData(
              minX: 0.5,
              maxX: totalDays.toDouble() + 0.5,
              minY: 0,
              maxY: maxY + yInterval,
              backgroundColor: const Color.fromARGB(255, 245, 244, 244),
              clipData: FlClipData.all(),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    interval: xInterval.toDouble(),
                    getTitlesWidget: (value, meta) {
                      if (value % xInterval == 0 && value <= totalDays + 0.5) {
                        return Text(
                          '${value.toInt()}',
                          style: const TextStyle(fontSize: 10),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 36,
                    interval: yInterval,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Text(
                          '${value.toInt()}',
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(left: BorderSide(), bottom: BorderSide()),
              ),
              gridData: FlGridData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: false,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                  color: Colors.blue,
                  barWidth: 2.5,
                ),
              ],
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.black87,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        '$X_axis_heading: ${spot.x.toInt()}\n$Y_axis_heading: ${spot.y.toInt()}',
                        const TextStyle(color: Colors.white, fontSize: 12),
                      );
                    }).toList();
                  },
                ),
                handleBuiltInTouches: true,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
