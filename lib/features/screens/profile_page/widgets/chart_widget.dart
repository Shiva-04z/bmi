import 'package:bmi/features/screens/profile_page/profile_page_controller.dart';
import 'package:bmi/features/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../data/models/bmi.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.find<ProfilePageController>();

    return ((controller.profile.historyMap.isEmpty)
        ? const Center(
            child: Text(
              'No history data available',
              style: TextStyle(color: Colors.grey),
            ),
          )
        : Column(
            children: [
              Container(
                height: 400,
                padding: const EdgeInsets.all(8),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    title: const AxisTitle(text: 'Days'),
                    labelRotation: 0,
                    interval: 1,
                    majorGridLines: const MajorGridLines(width: 0),
                  ),
                  primaryYAxis: const NumericAxis(
                    title: AxisTitle(text: 'Values'),
                  ),
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    toggleSeriesVisibility: true,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: _buildGroupedSeries(controller.profile.historyMap),
                ),
              ),
            ],
          ));
  }

  List<CartesianSeries<GroupedChartData, String>> _buildGroupedSeries(
    Map<String, BMI> historyMap,
  ) {
    final List<GroupedChartData> weightData = [];
    final List<GroupedChartData> heightData = [];
    final List<GroupedChartData> bmiData = [];

    // Oldest → Newest (6 days ago to today)
    for (int i = 6; i >= 0; i--) {
      final date = DateTime.now().subtract(Duration(days: i));
      final isoDate = _onlyDate(date);
      final label = _formatDate(date);

      final bmi = historyMap[isoDate];

      weightData.add(
        GroupedChartData(day: label, value: bmi?.weight ?? 0, type: 'Weight'),
      );

      heightData.add(
        GroupedChartData(day: label, value: bmi?.height ?? 0, type: 'Height'),
      );

      bmiData.add(
        GroupedChartData(day: label, value: bmi?.bmi ?? 0, type: 'BMI'),
      );
    }

    return [
      ColumnSeries<GroupedChartData, String>(
        dataSource: weightData,
        name: 'Weight (kg)',
        xValueMapper: (data, _) => data.day,
        yValueMapper: (data, _) => data.value,
        color: Colors.blue,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        animationDuration: 500,
      ),
      ColumnSeries<GroupedChartData, String>(
        dataSource: heightData,
        name: 'Height (M)',
        xValueMapper: (data, _) => data.day,
        yValueMapper: (data, _) => double.parse(data.value.toStringAsFixed(2)),
        color: Colors.green,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        animationDuration: 500,
      ),
      ColumnSeries<GroupedChartData, String>(
        dataSource: bmiData,
        name: 'BMI',
        xValueMapper: (data, _) => data.day,
        yValueMapper: (data, _) => double.parse(data.value.toStringAsFixed(2)),
        color: Colors.orange,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        animationDuration: 500,
      ),
    ];
  }

  String _onlyDate(DateTime date) {
    return date.toIso8601String().split('T').first;
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}";
  }
}

class GroupedChartData {
  final String day;
  final double value;
  final String type;

  GroupedChartData({
    required this.day,
    required this.value,
    required this.type,
  });
}
